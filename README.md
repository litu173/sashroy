# MediCompare BD: landing page

The static marketing site for MediCompare BD, published on GitHub Pages. It tells the medicine-price story and links to the Android app download.

- No build step: `index.html` with inline CSS and JS, plus Lenis (from a CDN) for smooth scrolling.
- Preview locally: `python3 -m http.server 4321`, then open http://localhost:4321
- The Android download points to the rolling `latest-android` release in [medicompare-mobile](https://github.com/litu173/medicompare-mobile).
- Price figures come from the open, MedEx-derived dataset used by [medicompare-web](https://github.com/litu173/medicompare-web).
