---
title: "Why Diva.js?"
description: "Some unique features of Diva.js"
weight: 1
---

One of the best capabilities unlocked by the IIIF is the ability to choose the best kind of image viewer for a particular use. If you have access to the manifest, you can choose a viewer that gives you the tools you want.

Diva.js supports high-resolution image zooming, range navigation, and other "normal" features from other IIIF viewers. However, here are some reasons you might choose Diva.js for a unique perspective on your manifests:

- Scrolling interaction. The primary way to move through a document is continuous vertical scrolling of pages, rather than stepping through one image at a time. This has been a core interaction method in Diva.js since from before it was Diva.js, and we wanted to keep it this way for the new version.
- View openings...with a twist! Sometimes a sequence of page images will get interrupted with an insert or a deletion, causing the standard 'two-up' view for openings to get out of alignment. The "page shift" feature in Diva.js will move the layout of the images by one page, causing the images to line up again.
- Document image processing filters. Contrast, gamma, and threshold-style filters can make faded ink, bleed-through, or low-contrast scans more readable. Basic image manipulation tools, like rotate or mirror, can help read documents with marginalia or reversed text.
- Right-to-Left support for texts in languages such as Hebrew or Arabic.
- Language Map support, and browser language detection. Diva.js will attempt to honour the user's browser locale and match it with an appropriate language map value in a manifest.
- Two kinds of contents view. Diva.js features an "index"-style representation of the table of contents (enacted through the IIIF "ranges"), but it also features an "on-this-page" view where the contents of the current page are displayed as the user scrolls through the images.
