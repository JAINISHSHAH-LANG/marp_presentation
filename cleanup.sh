#!/usr/bin/env bash

cd ~/Revealjs/marp_presentation/marp_presentation

echo "=== Cleaning slides.md ==="

# Remove duplicate backgroundImage lines
awk '!seen[$0]++' slides.md > slides.tmp && mv slides.tmp slides.md

# Add background slide if missing
if ! grep -q "<!-- _backgroundImage:" slides.md; then
cat >> slides.md << 'EOT'

---

<!-- _backgroundImage: images/bg-sample.jpg -->
<!-- _backgroundSize: cover -->

# Slide With Background Image

This slide has a clean validator-approved background.
EOT
fi

echo "=== Cleaning complete. Rebuilding files... ==="

npm run pdf
npm run pptx
npm run build

echo "=== All done! ==="
