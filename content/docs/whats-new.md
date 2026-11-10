---
title: "What's New in Diva.js 7.6.0"
description: "Earlier loading previews, richer annotations, faster updates, and configurable logout controls"
weight: 1
---

Diva.js 7.6.0 improves the reading experience for large documents, expands annotation-body support, and gives host applications more control over authentication UI.

## Thumbnail-Backed Loading Previews

Nearby pages can show a thumbnail while their image tiles are loading. The real tiles progressively cover the preview, which is hidden after the visible image finishes drawing. This reduces blank-page waiting without downloading every nearby page at full resolution.

When manifest annotations are enabled, their data is requested in the same nearby preview band. Outlines appear once image coordinates are available. Thumbnail and annotation loading remain subject to the existing access policies; a missing thumbnail does not prevent the page itself from loading.

## Richer Annotation Bodies

Annotations can contain multiple textual bodies in IIIF Presentation API 2 and 3 resources and in annotations supplied through the JavaScript API. Bodies are displayed in source order, HTML fragments are sanitized independently, explicit plain text stays literal, and language/direction metadata is preserved.

Hover previews preserve paragraph and line breaks and use a larger, readable layout. Long previews identify the annotation itself as the click target: click the annotation outline, or focus it and press Enter, to open the full details panel. The moving hover preview is not a button.

See [Example Code](/docs/example-code/#use-multiple-textual-bodies) for a multi-body annotation example.

## Faster Updates and Image Processing

This release reduces repeated work in annotation updates, contents-range lookups, sidebar thumbnails, and image filters. Compatible pointwise filters can share canvas processing on opaque tiles, and PCA modes share projection/output machinery while preserving their distinct normalization behavior.

Existing page labels are repositioned without removing and recreating their OpenSeadragon overlays. These changes preserve the public API; they do not introduce page eviction or a configurable tile-prefetch window.

## Authentication and Host Integration

Diva can reuse an existing image-service session through the IIIF Authorization Flow API 2.0 `external` access profile, alongside the existing interactive `active` flow.

The new `showLogoutButton` constructor option defaults to `true`. Set it to `false` when the surrounding application already provides a logout control. This hides only Diva's logout buttons; it does not log the user out or disable image authentication. The logout control also has a distinct icon rather than sharing the Shift Pages icon.

See [Getting Started](/docs/getting-started/#configuration-options) for the options and [Example Code](/docs/example-code/#use-the-host-applications-logout-control) for an integration example.

## Earlier 7.5 Releases

Diva.js 7.5.1 fixed annotation loading for IIIF Presentation API 2 resources. The 7.5 releases introduced Web Annotation support and configurable static-image loading, described below.

### Web Annotations

Diva 7.5 can render annotations supplied by IIIF Presentation API 2 and 3 manifests when `enableAnnotations` is set. Integrations can also add, replace, inspect, select, and clear [Web Annotations](https://www.w3.org/TR/annotation-model/) through the public JavaScript API.

Rectangular `xywh` targets and inline SVG selectors are supported. Selecting an annotation opens its details panel and emits an `annotationselect` event; when the canvas has an Image API service, the panel can also provide an image extract for the annotated region.

See [Example Code](/docs/example-code/#add-annotations-programmatically) for integration patterns and the [Annotation API example](/try/annotations/) for a live demonstration.

### Static Image Loading

Static images now support configurable CORS loading. The default keeps filters and Save view available for CORS-enabled resources; optional fallback modes allow non-CORS images to remain viewable when pixel-processing features are not needed.

Read [Getting Started](/docs/getting-started/#iiif-and-image-access) before enabling a non-CORS fallback.
