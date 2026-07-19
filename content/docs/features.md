---
title: "Features"
description: "Core capabilities of Diva.js"
weight: 4
---

Diva.js is a IIIF image viewer built for document reading. The features below focus on how users move through pages, how they interpret difficult images, and how the viewer handles structured documents.

## Reading Experience

- **Scroll-first navigation**: Documents are read by continuously scrolling through pages, rather than stepping one image at a time. This keeps context visible and supports longer reading sessions.
- **Page view modal**: A zoomable single-page view, with optional fullscreen, a dedicated filter sidebar, and display of multiple "Choice" images on a canvas. 
- **Sidebar tools**: Thumbnails, contents, and metadata are available in a mobile-friendly resizable sidebar.
- **Responsive design**: Works across desktop and mobile screens with touch-friendly interaction.
- **Fullscreen**: Diva.js can display document images in full screen, which can be useful for presentations or other group interactions.

## Image Interpretation Tools

- **Document image processing filters**: Contrast, gamma, threshold, rotation, mirror, and advanced colour adjustments help make faint or complex images more legible.
- **Filter pipelines**: Multiple filters can be layered and tuned to adapt to different material within a session.
- **Save filter settings**: Filter settings can be exported as JSON so they can be re-applied to other pages.

## IIIF Features

- **IIIF Presentation API v2 and v3 support**: Works with manifests and collections.
- **Ranges / structures navigation**: Table-of-contents style navigation through ranges.
- **On-this-page contents**: A second contents mode highlights the structure relevant to the pages currently in view.
- **Multi-image canvases**: When a canvas contains more than one image, a page-view selector lets you choose among them.
- **Language maps and locale selection**: Uses IIIF language maps and can prefer values that match the user’s browser locale.
- **Right-to-left documents**: Supports RTL reading order for documents such as Hebrew or Arabic texts.
- **Manifest information panel**: View manifest metadata, summary, viewing behavior/direction, and provider details.
- **Collection explorer**: Browse IIIF collections with an expandable tree and select manifests from within the viewer.
- **Image service compatibility**: Loads IIIF Image API 1, 2, and 3 services as well as CORS-enabled static images.
- **Authorized images**: Supports the IIIF Authorization Flow API 2.0 `active` access profile and optional logout services.

## Integration Features

- **Public JavaScript API**: Read stable page and viewer state, navigate, replace resources, control layouts and zoom, and destroy viewers cleanly.
- **Typed events**: Listen for ready, resource, page, layout, zoom, loading, fullscreen, and error changes.
- **npm and ES modules**: Use the browser or ES module build with published TypeScript declarations.
- **Deep-link building blocks**: Find and open pages by zero-based index, exact canvas ID, or complete localized label while retaining control of application URLs and history.
