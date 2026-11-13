#!/usr/bin/env sh
# repoviz export.sh -- download rendered diagrams (SVG/PNG) from draw URLs.
# Usage:
#   sh scripts/export.sh "<draw_url>" "<output.svg|png>"     # single
#   sh scripts/export.sh --batch <file>                      # batch, one "url<TAB>out" per line
#   sh scripts/export.sh --batch -                           # batch, manifest on stdin
# Security: curl-only download of the explicit URL. Optional fallbacks invoke
# *locally installed* CLIs (x / x-cmd / draw). No package is ever fetched,
# installed, or executed from a registry.
set -u

PROG=${0##*/}
UA="repoviz/1.0 (+https://x-cmd.com/draw)"

die() { printf '%s: %s\n' "$PROG" "$*" >&2; exit 2; }

have() { command -v "$1" >/dev/null 2>&1; }

valid_svg() { [ -s "$1" ] && { head -c 5 "$1" | grep -q '<'; }; }
valid_png() { [ -s "$1" ] && [ "$(od -An -tx1 -N4 "$1" 2>/dev/null | tr -d ' \n')" = "89504e47" ]; }

# Download one url -> out. Returns 0 on success, 1 on failure.
fetch_one() {
  url=$1
  out=$2

  # Renderer allowlist: only x-cmd.com draw URLs (any other host could be a
  # tracking pixel or data trap, and HTML escaping cannot constrain requests).
  case $url in
    "https://x-cmd.com/draw"|"https://x-cmd.com/draw?"*|"https://x-cmd.com/draw/"*|\
    "https://www.x-cmd.com/draw"|"https://www.x-cmd.com/draw?"*|"https://www.x-cmd.com/draw/"*) ;;
    *) printf 'FAIL %s -> %s\n  not an x-cmd.com draw URL (https://x-cmd.com/draw...)\n' "$url" "$out"; return 1 ;;
  esac

  fmt=svg
  case $out in
    *.svg) fmt=svg ;;
    *.png) fmt=png ;;
    *) printf 'FAIL %s -> %s\n  output must end in .svg or .png\n' "$url" "$out"; return 1 ;;
  esac

  # PNG targets need format=png; SVG targets must not carry format=png.
  if [ "$fmt" = png ]; then
    case $url in
      *[?\&]format=*) : ;; # explicit format already set -- respect it
      *\?*)             url="$url&format=png" ;;
      *)                url="$url?format=png" ;;
    esac
  else
    case $url in
      *[?\&]format=png*) printf 'FAIL %s -> %s\n  URL requests format=png but output is .svg\n' "$url" "$out"; return 1 ;;
    esac
  fi

  dir=${out%/*}
  [ "$dir" = "$out" ] && dir=.
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" || { printf 'FAIL %s -> %s\n  cannot create directory\n' "$url" "$out"; return 1; }
  fi

  tmp="$out.part.$$"
  trap 'rm -f "$tmp"' 0 HUP INT TERM

  # Everything after the host's "/draw" (path + "?..." query) for CLI fallbacks.
  q=${url#*/draw}
  case $q in \?*|/*) ;; *) q="" ;; esac

  # Primary path: curl (required for the default zero-dependency workflow).
  if have curl; then
    if curl -fsSL -A "$UA" "$url" -o "$tmp" 2>/dev/null; then
      if { [ "$fmt" = png ] && valid_png "$tmp"; } || { [ "$fmt" != png ] && valid_svg "$tmp"; }; then
        mv "$tmp" "$out"
        printf 'saved: %s (%s bytes)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
        return 0
      fi
      printf 'FAIL %s -> %s\n  downloaded content failed validation\n' "$url" "$out"
      rm -f "$tmp"
      return 1
    fi
  fi

  # Fallbacks: locally installed draw CLIs only. Best effort, never required.
  if [ -n "$q" ]; then
    if have x && x draw "$q" >"$tmp" 2>/dev/null && { [ "$fmt" = png ] || valid_svg "$tmp"; }; then
      mv "$tmp" "$out"; printf 'saved: %s (%s bytes, via x draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"; return 0
    fi
    if have x-cmd && x-cmd draw "$q" >"$tmp" 2>/dev/null && { [ "$fmt" = png ] || valid_svg "$tmp"; }; then
      mv "$tmp" "$out"; printf 'saved: %s (%s bytes, via x-cmd draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"; return 0
    fi
    if have draw; then
      if [ "$fmt" = png ]; then
        if draw "$q" --out "$tmp" >/dev/null 2>&1 && valid_png "$tmp"; then
          mv "$tmp" "$out"; printf 'saved: %s (%s bytes, via draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"; return 0
        fi
      else
        if draw "$q" >"$tmp" 2>/dev/null && valid_svg "$tmp"; then
          mv "$tmp" "$out"; printf 'saved: %s (%s bytes, via draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"; return 0
        fi
      fi
    fi
  fi
  rm -f "$tmp"
  printf 'FAIL %s -> %s\n  download failed (curl error or renderer 4xx)\n' "$url" "$out"
  return 1
}

# ---- batch mode ----
if [ "${1:-}" = "--batch" ]; then
  [ $# -eq 2 ] || die "usage: sh $PROG --batch <file|->"
  src=$2
  if [ "$src" != "-" ] && [ ! -f "$src" ]; then die "no such manifest: $src"; fi
  [ "$src" = "-" ] && src=/dev/stdin
  pass=0; fail=0
  # TSV manifest: <url> \t <output>; lines starting with # are comments
  while IFS="$(printf '\t')" read -r u o || [ -n "${u:-}" ]; do
    [ -n "${u:-}" ] || continue
    case $u in \#*) continue ;; esac
    if fetch_one "$u" "$o"; then pass=$((pass+1)); else fail=$((fail+1)); fi
  done < "$src"
  printf 'summary: %d saved, %d failed\n' "$pass" "$fail"
  if [ "$fail" -eq 0 ]; then exit 0; else exit 1; fi
fi

[ $# -eq 2 ] || die "usage: sh $PROG \"<draw_url>\" \"<output.svg|png>\" | sh $PROG --batch <file|->"
fetch_one "$1" "$2"
