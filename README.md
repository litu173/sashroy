# সাশ্রয় · Sashroy: landing page

The static marketing site for Sashroy (সাশ্রয়, "saving"), formerly MediCompare BD, published on GitHub Pages. It tells the medicine-price story and links to the Android app download.

- No build step: `index.html` with inline CSS and JS, plus Lenis (from a CDN) for smooth scrolling.
- Preview locally: `python3 -m http.server 4321`, then open http://localhost:4321
- The Android download points to the rolling `latest-android` release in [medicompare-mobile](https://github.com/litu173/medicompare-mobile).
- Price figures come from the open, MedEx-derived dataset used by [medicompare-web](https://github.com/litu173/medicompare-web).

## Share the store publicly (free)

The store runs on a Mac. A free Cloudflare quick tunnel gives it a public HTTPS link that works from any network.

```bash
cd ../web && npm run build && npm run start -- -H 0.0.0.0 -p 3000   # terminal 1
cd ../site && ./share.sh                                         # terminal 2
```

`share.sh` writes the new link into `config.js` and pushes it, so the landing page's "Order" buttons always point to the live store. Enter the same link in the app under Account → Server address. The link changes every time the tunnel restarts, and it only works while the Mac is on.
