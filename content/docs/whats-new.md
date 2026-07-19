---
title: "What's New in Diva.js 7.4.0"
description: "Public API, authorization, packaging, and loading improvements in Diva.js 7.4.0"
weight: 1
---

Diva.js 7.4.0 adds a supported integration API, TypeScript declarations, and authenticated image access while retaining the document-reading interface introduced in Diva.js 7.

## IIIF Authorization Flow API 2.0

Diva.js now supports the IIIF Authorization Flow API 2.0 `active` access profile and optional logout services. Authorization API 2.0 `kiosk` and `external` profiles, Authentication API 1.0, substitutes, and tiered access remain outside the supported scope.

## IIIF Image API 1.0

Some services still use the older IIIF Image API 1.0; Diva.js now supports them.

## Public JavaScript API

Applications can now wait for viewer readiness, inspect page and viewer state, navigate by page index, canvas ID, or label, change layouts and resources, zoom to image regions, enter fullscreen, and cleanly destroy a viewer.

```javascript
const viewer = new Diva("diva-wrapper", { objectData: manifestUrl });
await viewer.ready;

console.log(viewer.getCurrentPage());
await viewer.goToPage({ by: "label", value: "Folio 12r" });
```

Typed events report readiness, resource, page, layout, zoom, loading, fullscreen, and recoverable error changes. The complete contract is in the [API reference](/docs/api/).

## npm, ES Modules, and TypeScript

The npm package now publishes browser and ES module builds with TypeScript declarations. `Diva` is available as both the default and named ES module export, and the public state, page, event, option, and navigation types are exported alongside it.

## New Constructor Options

The initial viewer can open at a zero-based page index, exact canvas ID, or localized page label. Integrations can also choose the initial sidebar width and the thumbnails, contents, or metadata panel.

See [Getting Started](/docs/getting-started/#configuration-options) for the complete option table.

## All the small things

- Thumbnail images are now lazy-loaded as they approach the sidebar viewport, reducing unnecessary image requests for long documents.
- Fixed duplicate tile-source resolution requests while loading the first image.
- Opening at a distant initial page no longer loads page zero first.
- Fixed resource-loading races so a late response from an older request cannot replace the currently active document.
- When replacing a resource fails, Diva.js restores the previous document, page, layout, viewport position, and zoom before reporting a recoverable error.
- Improved authorization session reuse so an existing session can be detected without prompting, while duplicate or simultaneous login requests are deduplicated and queued.
- Unavailable image sources are isolated from the rest of the document and are no longer retried automatically; superseded preview, authorization, and tile requests are cancelled.
- Improved table-of-contents highlighting and indentation for current and nested ranges.
- Added accessible labels to modal close buttons and made toolbar, sidebar, modal, and collection styling more consistent.
- Improved production minification and package-build reliability.
