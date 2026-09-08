---
title: "What's New in Diva.js 7.5.1"
description: "IIIF Presentation 2 annotation fix and 7.5 Web Annotation support"
weight: 1
---

Diva.js 7.5.1 is a compatibility update to the 7.5 release. It fixes annotation loading for IIIF Presentation API 2 resources while retaining the new Web Annotation support and static-image loading improvements.

## Web Annotations

Diva 7.5 can render annotations supplied by IIIF Presentation API 2 and 3 manifests when `enableAnnotations` is set. Integrations can also add, replace, inspect, select, and clear [Web Annotations](https://www.w3.org/TR/annotation-model/) through the public JavaScript API.

Rectangular `xywh` targets and inline SVG selectors are supported. Selecting an annotation opens its details panel and emits an `annotationselect` event; when the canvas has an Image API service, the panel can also provide an image extract for the annotated region.

See [Example Code](/docs/example-code/#add-annotations-programmatically) for integration patterns and the [Annotation API example](/try/annotations/) for a live demonstration.

## Static Image Loading

Static images now support configurable CORS loading. The default keeps filters and Save view available for CORS-enabled resources; optional fallback modes allow non-CORS images to remain viewable when pixel-processing features are not needed.

Read [Getting Started](/docs/getting-started/#iiif-and-image-access) before enabling a non-CORS fallback.
