---
title: "Events"
description: "Reacting to page, zoom, and loading changes"
weight: 2
---

Diva.js dispatches `CustomEvent`s as the viewer state changes, so you can keep
external UI in sync — a page counter, per-page transcription or OCR, a tag overlay,
a "currently loading" indicator, and so on.

## Available events

| Event                 | `detail`             | Fires when                                      |
|-----------------------|----------------------|-------------------------------------------------|
| `diva-page-change`    | `{ index, instant }` | the current page changes (`index` is 0-based)   |
| `diva-zoom-change`    | `{ zoom }`           | the zoom level changes (`zoom` is the OpenSeadragon viewport zoom) |
| `diva-loading-change` | `{ loading }`        | tiles start (`true`) or finish (`false`) loading |

For `diva-page-change`, `instant` is `true` on the initial page report (and other
programmatic jumps) and absent for ordinary user-driven page changes.

## Listening

The events are dispatched on the inner `<osd-viewer>` element that Diva renders
inside your container, **not** on the root element you passed to `new Diva(...)`:

```js
const viewer = document.querySelector('osd-viewer');

viewer.addEventListener('diva-page-change', (e) => {
    console.log('page', e.detail.index, e.detail.instant);
});

viewer.addEventListener('diva-zoom-change', (e) => {
    console.log('zoom', e.detail.zoom);
});

viewer.addEventListener('diva-loading-change', (e) => {
    console.log('loading', e.detail.loading);
});
```

## Notes

- `<osd-viewer>` is created **asynchronously** after `new Diva(...)` returns, so it
  may not exist the instant your initialisation code runs. Query for it after the
  viewer has rendered, or use the capture approach below.
- These events are dispatched with `bubbles: false`. A delegated listener on an
  ancestor therefore won't catch them in the bubble phase. A **capturing** listener
  on an ancestor still does — handy when you control the wrapper but the
  `<osd-viewer>` is created later:

  ```js
  document.getElementById('diva-wrapper').addEventListener(
      'diva-page-change',
      (e) => console.log('page', e.detail.index),
      true, // capture: reaches the non-bubbling event on the descendant
  );
  ```
