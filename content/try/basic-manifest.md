---
title: "Basic Manifest"
description: "A simple example loading a single IIIF manifest"
weight: 1
---

This example demonstrates loading a basic IIIF manifest.

## Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Diva.js Basic Example</title>
  <style>
    #diva-viewer {
      width: 100%;
      height: 600px;
    }
  </style>
</head>
<body>
  <div id="diva-viewer"></div>

  <script src="diva.js"></script>
  <script>
    const app = Elm.Main.init({
      node: document.getElementById('diva-viewer'),
      flags: {
        objectData: 'https://iiif.bodleian.ox.ac.uk/iiif/manifest/e32a277e-91e2-4a6d-8ba6-cc4bad230410.json',
        acceptHeaders: [],
        showSidebar: true,
        showTitle: true
      }
    });
  </script>
</body>
</html>
```

## Notes

- The `objectData` URL points to any valid IIIF Presentation API v2 or v3 manifest
- Set `showSidebar: false` to hide the thumbnail sidebar initially
- Set `showTitle: false` to hide the manifest title above the viewer
