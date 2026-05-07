#!/usr/bin/env bash
# Once Vercel gives you the live URL, run:
#   ./scripts/set-url.sh https://your-project.vercel.app
#
# This swaps [YOUR_VERCEL_URL] everywhere it appears (landing OG tags,
# canonical, robots.txt, sitemap.xml, AND the newsletter's CTAs).

set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <vercel-url>"
  echo "Example: $0 https://reshma-henna.vercel.app"
  exit 1
fi

URL="${1%/}"  # strip trailing slash
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "Replacing [YOUR_VERCEL_URL] -> $URL"

# Landing page meta + sitemap + robots
for f in "$ROOT/landing/index.html" "$ROOT/landing/sitemap.xml" "$ROOT/landing/robots.txt"; do
  if [ -f "$f" ]; then
    sed -i "s|https://\[YOUR_VERCEL_URL\]|$URL|g" "$f"
    sed -i "s|\[YOUR_VERCEL_URL\]|${URL#https://}|g" "$f"
    echo "  patched $f"
  fi
done

# Newsletter CTAs: point bundle/hero to landing instead of reshmabeauty.com
NEWS="$ROOT/index.html"
if [ -f "$NEWS" ]; then
  sed -i "s|https://reshmabeauty.com/collections/shampoo-conditioner?utm_source=email&amp;utm_medium=newsletter&amp;utm_campaign=henna_bundle_30&amp;utm_content=hero_cta|$URL/?utm_source=email\&amp;utm_medium=newsletter\&amp;utm_campaign=henna_bundle_30\&amp;utm_content=hero_cta|g" "$NEWS"
  sed -i "s|https://reshmabeauty.com/collections/shampoo-conditioner?discount=HENNA30&amp;utm_source=email&amp;utm_medium=newsletter&amp;utm_campaign=henna_bundle_30&amp;utm_content=bundle_primary|$URL/#bundle?utm_source=email\&amp;utm_medium=newsletter\&amp;utm_campaign=henna_bundle_30\&amp;utm_content=bundle_primary|g" "$NEWS"
  sed -i "s|https://reshmabeauty.com/collections/shampoo-conditioner?discount=HENNA30&amp;utm_source=email&amp;utm_medium=newsletter&amp;utm_campaign=henna_bundle_30&amp;utm_content=bundle_reinforce|$URL/#bundle?utm_source=email\&amp;utm_medium=newsletter\&amp;utm_campaign=henna_bundle_30\&amp;utm_content=bundle_reinforce|g" "$NEWS"
  echo "  patched $NEWS (bundle CTAs now point to landing)"
fi

echo ""
echo "Done. Verify with:  grep -r '[YOUR_VERCEL_URL]' landing/ index.html  (should return nothing)"
