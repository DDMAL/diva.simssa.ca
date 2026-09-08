---
title: "Example Code"
description: "Common Diva.js integration patterns for URLs and events"
weight: 3
---

These examples build on the viewer setup described in [Getting Started](/docs/getting-started/). Diva.js leaves the page URL and browser history under the host application's control, so an integration can choose its own linking conventions.

## Load a Manifest From `?manifest=`

Use `URLSearchParams` to read and decode a manifest URL from the page's query string, then pass it to `objectData`:

```javascript
const query = new URLSearchParams(window.location.search);
const manifestUrl = query.get("manifest");

if (!manifestUrl) {
  throw new Error("The URL must include a ?manifest= parameter.");
}

const viewer = new Diva("diva-wrapper", {
  objectData: manifestUrl
});
```

Construct links with `URL` and `URLSearchParams` so the manifest URL is encoded safely:

```javascript
const link = new URL(window.location.href);
link.searchParams.set("manifest", "https://example.org/iiif/manifest.json");

console.log(link.href);
```

The manifest and its image services must allow cross-origin requests from the page hosting Diva.js.

## Open a Page From `#p=`

One useful hash convention supports exact Canvas IDs, complete localized page labels, and one-based page numbers:

- `#p=canvas:https://example.org/canvas/12`
- `#p=label:Folio 12r`
- `#p=page:12`

Parse the value into an `initialPage` target before creating the viewer:

```javascript
function initialPageFromHash(hash) {
  const value = new URLSearchParams(hash.slice(1)).get("p");

  if (value?.startsWith("canvas:")) {
    return {
      by: "canvasId",
      value: value.slice("canvas:".length)
    };
  }

  if (value?.startsWith("label:")) {
    return {
      by: "label",
      value: value.slice("label:".length)
    };
  }

  if (value?.startsWith("page:")) {
    const pageNumber = Number(value.slice("page:".length));
    return Number.isInteger(pageNumber) && pageNumber > 0
      ? pageNumber - 1
      : undefined;
  }

  return undefined;
}

const initialPage = initialPageFromHash(window.location.hash);

const viewer = new Diva("diva-wrapper", {
  objectData: manifestUrl,
  initialPage
});
```

Diva.js uses zero-based numeric indexes, so this example converts the link's one-based `page:` value before passing it to the constructor. Canvas IDs match exactly. Labels match the complete localized display label case-insensitively, with the first matching page selected when labels are duplicated.

When generating a hash, use `URLSearchParams` so Canvas IDs and labels are encoded correctly:

```javascript
const hash = new URLSearchParams({
  p: `canvas:${canvasId}`
});

history.replaceState(null, "", `#${hash}`);
```

## Listen for Viewer Events

`Diva` extends `EventTarget`, so integrations can use the standard `addEventListener` API. Register listeners immediately after constructing the viewer:

```javascript
const viewer = new Diva("diva-wrapper", {
  objectData: manifestUrl,
  initialPage
});

viewer.addEventListener("ready", (event) => {
  console.log("Viewer ready", event.detail);
}, { once: true });

viewer.addEventListener("pagechange", (event) => {
  const { pageIndex, page, visiblePages } = event.detail;
  console.log("Current page", pageIndex, page.canvasId, visiblePages);
});

viewer.addEventListener("error", (event) => {
  const { error, operation, recoverable } = event.detail;
  console.error(operation, error.message, { recoverable });
});
```

The event name determines the type of `event.detail` when using the package's TypeScript declarations. See the [`addEventListener` API documentation](/docs/api/classes/Diva.html#addeventlistener) and the complete [`DivaEventMap`](/docs/api/interfaces/DivaEventMap.html) for all supported events and their payloads.

If an application only needs to wait for initial readiness, it can also use the promise API:

```javascript
await viewer.ready;
console.log(viewer.getState());
```

## Add Annotations Programmatically

Set `enableAnnotations` to load annotations declared by a IIIF manifest. After the manifest is ready, use a Canvas ID from `viewer.getPages()` to add [Web Annotations](https://www.w3.org/TR/annotation-model/) from your application. Diva.js supports rectangular `xywh` targets and inline SVG selectors.

```javascript
const viewer = new Diva("diva-wrapper", {
  objectData: manifestUrl,
  enableAnnotations: true
});
```

`enableAnnotations` only loads annotations advertised by the manifest. API-supplied annotations work independently of that option.

### Add a Rectangular Annotation

This example adds a comment to a 600 × 400 pixel region. Coordinates are measured in the Canvas's full-resolution image pixels:

```javascript
await viewer.ready;

const canvasId = viewer.getCurrentPage().canvasId;

viewer.setAnnotation({
  id: "https://example.org/annotations/reading-note-1",
  type: "Annotation",
  motivation: "commenting",
  body: {
    type: "TextualBody",
    format: "text/html",
    value: "<p>Look closely at this illuminated initial.</p>"
  },
  target: {
    type: "SpecificResource",
    source: canvasId,
    selector: {
      type: "FragmentSelector",
      conformsTo: "http://www.w3.org/TR/media-frags/",
      value: "xywh=180,420,600,400"
    }
  }
});
```

`setAnnotation` adds an annotation, or replaces an API-supplied annotation with the same `id`.

### Add Multiple Annotations, Including SVG

`setAnnotations` replaces the annotations previously supplied through the JavaScript API. It does not discard annotations loaded from the manifest.

```javascript
const canvasId = viewer.getPages()[0].canvasId;

viewer.setAnnotations([
  {
    id: "https://example.org/annotations/rectangle-1",
    type: "Annotation",
    body: { type: "TextualBody", value: "A rectangular note" },
    target: `${canvasId}#xywh=80,120,320,180`
  },
  {
    id: "https://example.org/annotations/shape-1",
    type: "Annotation",
    body: { type: "TextualBody", value: "An irregular shape" },
    target: {
      type: "SpecificResource",
      source: canvasId,
      selector: {
        type: "SvgSelector",
        value: "<svg xmlns='http://www.w3.org/2000/svg'><polygon points='600,120 760,190 680,350 540,280'/></svg>"
      }
    }
  }
]);
```

For an SVG selector, Diva.js draws the shape itself. When an Image API extract is requested, it uses the rectangle that encloses the shape.

### Read, Link, and Clear Annotations

The getters return defensive copies, so callers can safely transform their results. `getImageRegionForAnnotation` returns the same 320-pixel-bounded IIIF Image API region used by the annotation panel, or `null` when no usable Image API region is available.

```javascript
const annotations = viewer.getAnnotationsForCanvas(canvasId);
const allAnnotations = viewer.getAllAnnotations();

const annotation = annotations[0];
const body = viewer.getAnnotationBody(annotation.id);
const imageRegionUrl = viewer.getImageRegionForAnnotation(annotation.id);

console.log({ body, imageRegionUrl, total: allAnnotations.length });

// Remove every manifest and API-supplied annotation on this Canvas.
viewer.clearAnnotationsForCanvas(canvasId);

// Or remove every annotation from the loaded manifest.
viewer.clearAllAnnotations();
```

### Respond to Annotation Selection

By default, viewers allow people to click or activate an annotation with the keyboard. This opens the details panel and emits an `annotationselect` event. Applications can disable that interaction with `enableAnnotationSelection: false` or change it later with `setAnnotationSelectionEnabled`.

```javascript
viewer.addEventListener("annotationselect", (event) => {
  const { annotationId } = event.detail;
  console.log(viewer.getAnnotationBody(annotationId));
});

viewer.setAnnotationSelectionEnabled(false);
```
