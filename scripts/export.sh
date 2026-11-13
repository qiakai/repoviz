#!/usr/bin/env sh
# repoviz export.sh — download a rendered diagram (SVG/PNG) from a draw URL.
# Usage: sh scripts/export.sh "<draw_url>" "<output.svg|png>"
set -u

PROG=${0##*/}
UA="repoviz/1.0 (+https://x-cmd.com/draw)"

die() { printf '%s: %s\n' "$PROG" "$*" >&2; exit 1; }

[ $# -eq 2 ] || die "usage: sh $PROG \"<draw_url>\" \"<output.svg|png>\""

url=$1
out=$2

case $url in
  http://*"/draw"*|https://*"/draw"*) ;;
  *) die "not a draw URL (expected https://x-cmd.com/draw...): $url" ;;
esac

fmt=svg
case $out in
  *.svg) fmt=svg ;;
  *.png) fmt=png ;;
  *) die "output must end in .svg or .png: $out" ;;
esac

# PNG targets need format=png; SVG targets must not carry format=png.
if [ "$fmt" = png ]; then
  case $url in
    *[?\&]format=*) : ;; # explicit format already set — respect it
    *\?*)             url="$url&format=png" ;;
    *)                url="$url?format=png" ;;
  esac
else
  case $url in
    *[?\&]format=png*) die "URL requests format=png but output is .svg — drop format=png from the URL" ;;
  esac
fi

dir=${out%/*}
[ "$dir" = "$out" ] && dir=.
[ -d "$dir" ] || mkdir -p "$dir" || die "cannot create directory: $dir"

tmp="$out.part.$$"
trap 'rm -f "$tmp"' 0 HUP INT TERM

have() { command -v "$1" >/dev/null 2>&1; }

# Everything after the host's "/draw" (path + "?..." query) for CLI fallbacks.
q=${url#*/draw}
case $q in \?*|/*) ;; *) q="" ;; esac

valid_svg() { [ -s "$1" ] && { head -c 5 "$1" | grep -q '<'; }; }
valid_png() { [ -s "$1" ] && [ "$(od -An -tx1 -N4 "$1" 2>/dev/null | tr -d ' \n')" = "89504e47" ]; }
valid_file() { if [ "$fmt" = png ]; then valid_png "$1"; else valid_svg "$1"; fi; }

# Primary path: curl (required for the default zero-dependency workflow).
if have curl; then
  if curl -fsSL -A "$UA" "$url" -o "$tmp" 2>/dev/null && valid_file "$tmp"; then
    mv "$tmp" "$out"
    printf 'saved: %s (%s bytes)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
    exit 0
  fi
fi

# Fallbacks: a local draw CLI (x-cmd / npm @x-cmd/draw). Best effort, never required.
if [ -n "$q" ]; then
  if have x && x draw "$q" >"$tmp" 2>/dev/null && valid_file "$tmp"; then
    mv "$tmp" "$out"
    printf 'saved: %s (%s bytes, via x draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
    exit 0
  fi
  if have x-cmd && x-cmd draw "$q" >"$tmp" 2>/dev/null && valid_file "$tmp"; then
    mv "$tmp" "$out"
    printf 'saved: %s (%s bytes, via x-cmd draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
    exit 0
  fi
  if have draw; then
    if [ "$fmt" = png ]; then
      if draw "$q" --out "$tmp" >/dev/null 2>&1 && valid_file "$tmp"; then
        mv "$tmp" "$out"
        printf 'saved: %s (%s bytes, via draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
        exit 0
      fi
    else
      if draw "$q" >"$tmp" 2>/dev/null && valid_file "$tmp"; then
        mv "$tmp" "$out"
        printf 'saved: %s (%s bytes, via draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
        exit 0
      fi
    fi
  fi
  if have npx; then
    if [ "$fmt" = png ]; then
      if npx --yes @x-cmd/draw "$q" --out "$tmp" >/dev/null 2>&1 && valid_file "$tmp"; then
        mv "$tmp" "$out"
        printf 'saved: %s (%s bytes, via npx @x-cmd/draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
        exit 0
      fi
    else
      if npx --yes @x-cmd/draw "$q" >"$tmp" 2>/dev/null && valid_file "$tmp"; then
        mv "$tmp" "$out"
        printf 'saved: %s (%s bytes, via npx @x-cmd/draw)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
        exit 0
      fi
    fi
  fi
fi

die "download failed (curl error or renderer 4xx — open the URL in a browser to see the diagnostic message)"
