#!/usr/bin/env bash
# Opens a free Cloudflare tunnel to the store on this Mac and publishes the new link
# to the landing page (config.js → GitHub Pages). Keep this window open while testing.
#
#   1. In web/:  npm run build && npm run start -- -H 0.0.0.0 -p 3000
#   2. In site/: ./share.sh
set -euo pipefail
cd "$(dirname "$0")"
PORT="${PORT:-3000}"
LOG="$(mktemp)"

if ! curl -s -o /dev/null --max-time 5 "http://localhost:$PORT"; then
  echo "The store isn't running on port $PORT. Start it first (see the top of this file)." >&2
  exit 1
fi

cloudflared tunnel --no-autoupdate --url "http://localhost:$PORT" >"$LOG" 2>&1 &
TUNNEL=$!
trap 'kill $TUNNEL 2>/dev/null' EXIT

URL=""
for _ in $(seq 1 30); do
  URL="$(grep -o 'https://[a-z0-9-]*\.trycloudflare\.com' "$LOG" | head -1 || true)"
  [ -n "$URL" ] && break
  sleep 1
done
[ -z "$URL" ] && { echo "Tunnel didn't start:"; cat "$LOG"; exit 1; }

cat > config.js <<JS
// Where the live MediCompare store is running. Updated by share.sh when the tunnel restarts.
window.MEDICOMPARE = {
  storeUrl: "$URL",
};
JS
if ! git diff --quiet config.js; then
  git add config.js && git commit -q -m "Point landing page at $URL" && git push -q
  echo "Landing page updated (GitHub Pages refreshes within about a minute)."
fi

echo
echo "Store link:        $URL"
echo "App server address: $URL   (Account → Server address in the app)"
echo "Press Ctrl+C to stop sharing."
wait $TUNNEL
