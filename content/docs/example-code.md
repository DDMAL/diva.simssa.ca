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
