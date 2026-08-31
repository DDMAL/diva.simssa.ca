---
title: "Getting Started"
description: "How to set up Diva.js in your project"
weight: 2
---

## Install Diva.js

Diva.js requires OpenSeadragon. You can load both browser bundles directly:

```html
<script src="https://cdn.jsdelivr.net/npm/openseadragon@6.1.0/build/openseadragon/openseadragon.min.js"></script>
<script src="path/to/diva.js"></script>
```

All Diva.js CSS and images are included in its bundle, so there is nothing else to load.

For an application built with npm:

```bash
npm install diva.js openseadragon
```

The package includes browser and ES module builds plus TypeScript declarations. OpenSeadragon must be available globally before a viewer is created:

```javascript
import OpenSeadragon from "openseadragon";
import Diva from "diva.js";

globalThis.OpenSeadragon = OpenSeadragon;
```

## Create a Viewer

Add a container and create a viewer with a IIIF manifest or collection URL:

```html
<div id="diva-wrapper"></div>

<script>
  const viewer = new Diva("diva-wrapper", {
    objectData: "https://example.org/manifest.json"
  });
</script>
```

Give the container an explicit height so the viewer can render correctly:

```css
#diva-wrapper {
  display: flex;
  width: 100%;
  height: 80vh;
}
```

Wait for the initial IIIF resource before reading page state or issuing commands:

```javascript
await viewer.ready;

const pages = viewer.getPages();
const currentPage = viewer.getCurrentPage();

await viewer.next();
```

See the [API reference](/docs/api/) for navigation, state, events, resource replacement, region zooming, and lifecycle methods.

## Configuration Options

The `Diva` constructor accepts a root element ID and an options object:

```javascript
const viewer = new Diva(rootElementId, options);
```

| Option | Type | Default | Description |
|---|---|---|---|
| `objectData` | `string` | required | URL to a IIIF manifest or collection |
| `initialPage` | `number \| DivaPageSelector` | `0` | Initial zero-based page index, exact canvas ID, or complete case-insensitive label |
| `acceptHeaders` | `string[]` | `[]` | Preferred HTTP Accept values for IIIF resource requests |
| `staticImageCorsPolicy` | `"required" \| "fallback" \| "none"` | `"required"` | CORS policy for static non-IIIF images; non-CORS images cannot use filters or Save view |
| `showSidebar` | `boolean` | `true` | Whether to show the navigation sidebar |
| `sidebarWidth` | `number` | `320` | Initial sidebar width, constrained to 220–520 CSS pixels |
| `sidebarPanel` | `"thumbnails" \| "contents" \| "metadata"` | `"thumbnails"` | Initially selected available sidebar panel |
| `showTitle` | `boolean` | `true` | Whether to show the resource title |
| `setLanguage` | `string` | browser language | Preferred interface language |

Page selectors use either an exact canvas identifier or a complete localized label:

```javascript
const viewer = new Diva("diva-wrapper", {
  objectData: manifestUrl,
  initialPage: { by: "label", value: "Folio 12r" },
  sidebarPanel: "contents",
  sidebarWidth: 360,
  staticImageCorsPolicy: "fallback"
});
```

`setLanguage` should normally be the language subtag of a [BCP 47 language tag](https://developer.mozilla.org/en-US/docs/Glossary/BCP_47_language_tag). For example, use `ar` for `ar-Latn` and `fr` for `fr-CA`.

## IIIF and Image Access

Diva.js supports:

- IIIF Presentation API 2 and 3 manifests, collections, ranges, and multiple images per canvas.
- IIIF Image API 1, 2, and 3 services.
- Static image resources, including servers that cannot provide CORS headers when configured with a non-CORS policy.
- The IIIF Authorization Flow API 2.0 `active` access profile, including optional logout services.

As of v7.4.3, Diva uses CORS by default (`staticImageCorsPolicy: "required"`) so Page View filters and Save view can read their pixels. Use `"fallback"` to automatically retry a failed static-image request once without CORS, or `"none"` to use non-CORS loading immediately. Non-CORS static images remain viewable, but filters and Save view are disabled because the browser taints their canvas.

Using `fallback` has significant drawbacks.

- Filters and Save view are unavailable, since a non-CORS image is marked as 'tainted' and cannot be loaded into a Canvas view.
- It makes an extra image request for each CORS-incompatible static image.
- In the current implementation, "fallback" selects Canvas/HTML rendering up front so non-CORS images can display. That forfeits WebGL acceleration for the
  viewer, including normal IIIF images in that session.
- It can mask a missing CORS configuration that an institution may prefer to fix.

Authorization API 2.0 `kiosk` and `external` profiles, Authentication API 1.0, substitutes, and tiered access are not currently supported.
