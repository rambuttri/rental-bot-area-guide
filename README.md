# Area Guide — GitHub Pages

Static interactive safety map shown when bot users click **📍 Area Guide → 🗺 Open interactive map**.

**Live URL:** https://rambuttri.github.io/rental-bot-area-guide/

## First-time setup (one-time, ~2 minutes)

1. Create an empty public repo at GitHub: **https://github.com/new**
   - Owner: `rambuttri`
   - Repository name: `rental-bot-area-guide`
   - Public (required for free GitHub Pages)
   - Do **not** add README/license (we already have one here)

2. From this folder, push:

   ```bash
   cd deploy/area-guide-pages
   ./publish.sh
   ```

   (the script inits git, commits, pushes to `main`, and prints the page URL)

3. Enable GitHub Pages:
   - Go to https://github.com/rambuttri/rental-bot-area-guide/settings/pages
   - Source: **Deploy from a branch**
   - Branch: `main` / root
   - Save

4. Wait ~1 minute. Site goes live at `https://rambuttri.github.io/rental-bot-area-guide/`

## Updating the map

Edit `index.html`, then:

```bash
./publish.sh
```

The script commits and pushes. GitHub Pages redeploys in ~30s.

## What's inside

- `index.html` — self-contained page with Leaflet map, safety zones for Cape Town & Johannesburg
- `.nojekyll` — tells GitHub Pages to serve files as-is (no Jekyll processing)
