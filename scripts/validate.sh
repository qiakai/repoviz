#!/usr/bin/env sh
# repoviz validate.sh — validation layers L1 (draw URL renders) and L2 (IR structure).
# Usage:
#   sh scripts/validate.sh <draw_url> [draw_url...]   # L1: reachable + valid SVG/PNG
#   sh scripts/validate.sh -                          # L1: read URLs from stdin, one per line
#   sh scripts/validate.sh --ir <file.json>           # L2: node/edge/evidence structure
# Exit 0 = all checks pass, 1 = a check failed, 2 = usage error.
# Security: read-only checks. Uses the locally installed python3 (if present) to
# parse IR JSON — nothing is downloaded, installed, or executed from a registry.
set -u

PROG=${0##*/}
UA="repoviz/1.0 (+https://x-cmd.com/draw)"

die() { printf '%s: %s\n' "$PROG" "$*" >&2; exit 2; }

[ $# -ge 1 ] || die "usage: sh $PROG <draw_url>... | - | --ir <file.json>"

have() { command -v "$1" >/dev/null 2>&1; }

# ---------------- L2: IR structure check ----------------

if [ "$1" = "--ir" ]; then
  [ $# -eq 2 ] || die "usage: sh $PROG --ir <file.json>"
  f=$2
  [ -f "$f" ] || die "no such file: $f"

  if have python3; then
    exec python3 - "$f" <<'PY'
import json, sys

path = sys.argv[1]
try:
    ir = json.load(open(path, encoding="utf-8"))
except Exception as e:
    print(f"FAIL not valid JSON: {e}")
    sys.exit(1)

fails, warns = [], []
if not isinstance(ir, dict):
    print("FAIL root must be a JSON object")
    sys.exit(1)

nodes = ir.get("nodes")
edges = ir.get("edges", [])
if not ir.get("version"):
    fails.append("missing 'version'")
if not isinstance(nodes, list) or not nodes:
    fails.append("'nodes' must be a non-empty list")
    nodes = []

ids = [n.get("id") for n in nodes if isinstance(n, dict)]
for n in nodes:
    if not isinstance(n, dict) or not n.get("id") or not n.get("label"):
        fails.append(f"node missing id/label: {json.dumps(n)[:80]}")
        continue
    for ev in n.get("evidence", []):
        if ev.get("level") == "verified" and not ev.get("file"):
            fails.append(f"node '{n['id']}' verified without file")
dup = {i for i in ids if ids.count(i) > 1}
if dup:
    fails.append(f"duplicate node ids: {sorted(dup)}")

idset = set(ids)
for e in edges:
    if not isinstance(e, dict):
        fails.append(f"edge not an object: {str(e)[:80]}")
        continue
    for k in ("from", "to"):
        if e.get(k) not in idset:
            fails.append(f"edge '{e.get('from','?')}→{e.get('to','?')}' dangling {k}")
    for ev in e.get("evidence", []):
        if ev.get("level") == "verified" and not ev.get("file"):
            fails.append(f"edge {e.get('from','?')}→{e.get('to','?')} verified without file")

levels = [ev.get("level") for o in nodes + edges for ev in o.get("evidence", [])]
known = {"verified", "inferred", "unknown", None}
bad_levels = {l for l in levels if l not in known}
if bad_levels:
    fails.append(f"bad evidence levels: {sorted(bad_levels)}")
if len(nodes) > 20:
    warns.append(f"{len(nodes)} nodes exceed the ~20-node budget — split the diagram")

counts = {l: levels.count(l) for l in ("verified", "inferred", "unknown")}
print(f"nodes={len(nodes)} edges={len(edges)} "
      f"evidence: verified {counts['verified']} · inferred {counts['inferred']} · unknown {counts['unknown']}")
for w in warns:
    print(f"WARN {w}")
if fails:
    for x in fails:
        print(f"FAIL {x}")
    sys.exit(1)
print("PASS")
PY
  fi

  # Portable fallback: without python3 only coarse checks are possible.
  grep -q '"nodes"' "$f" || { echo "FAIL no \"nodes\" key (python3 absent — limited checks)"; exit 1; }
  grep -q '"version"' "$f" || echo "WARN no \"version\" key (python3 absent — limited checks)"
  echo "WARN python3 not found — install it for full L2 checks (dangling refs, evidence levels)"
  echo "PASS (coarse)"
  exit 0
fi

# ---------------- L1: draw URL render check ----------------

have curl || die "curl is required for URL validation"

tmp="${TMPDIR:-/tmp}/$PROG.$$"
trap 'rm -f "$tmp"' 0 HUP INT TERM

valid_svg() { [ -s "$1" ] && head -c 5 "$1" | grep -q '<'; }
valid_png() { [ -s "$1" ] && [ "$(od -An -tx1 -N4 "$1" 2>/dev/null | tr -d ' \n')" = "89504e47" ]; }

if [ "$1" = "-" ]; then
  # shellcheck disable=SC2016
  urls=$(cat)
else
  urls=$*
fi

pass=0; fail=0
# Intentional word-splitting: one URL per argument/line.
# shellcheck disable=SC2086
for url in $urls; do
  case $url in
    http://*"/draw"*|https://*"/draw"*) ;;
    *) printf 'FAIL %s\n  not a draw URL\n' "$url"; fail=$((fail+1)); continue ;;
  esac
  if curl -fsSL -A "$UA" --max-time 30 "$url" -o "$tmp" 2>/dev/null; then
    case $url in
      *[?\&]format=png*)
        if valid_png "$tmp"; then printf 'PASS %s (png, %s bytes)\n' "$url" "$(wc -c < "$tmp" | tr -d ' ')"; pass=$((pass+1)); else printf 'FAIL %s\n  not a valid PNG\n' "$url"; fail=$((fail+1)); fi ;;
      *)
        if valid_svg "$tmp"; then printf 'PASS %s (svg, %s bytes)\n' "$url" "$(wc -c < "$tmp" | tr -d ' ')"; pass=$((pass+1)); else printf 'FAIL %s\n  response is not SVG\n' "$url"; fail=$((fail+1)); fi ;;
    esac
  else
    # 4xx bodies carry a plain-text correction example — surface its first line.
    code=$(curl -sSL -A "$UA" --max-time 30 -o "$tmp" -w '%{http_code}' "$url" 2>/dev/null)
    hint=$(head -n 1 "$tmp" 2>/dev/null | cut -c1-160)
    printf 'FAIL %s\n  HTTP %s %s\n' "$url" "$code" "$hint"
    fail=$((fail+1))
  fi
done

printf 'summary: %d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
