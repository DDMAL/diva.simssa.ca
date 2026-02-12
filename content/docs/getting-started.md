---
title: "Getting Started"
description: "How to set up Diva.js in your project"
weight: 1
---

## Installation

Diva.js is a IIIF-compliant image viewer. 

### Using the pre-built bundle

Include the Diva.js script in your HTML:

```html
<script src="path/to/diva.min.js"></script>
```



## Basic Usage

To embed Diva.js in your page, create a container element and initialise the viewer:

```html
<div id="diva-viewer"></div>

<script>
  const viewer = new Diva('diva-viewer', {
    objectData: 'https://example.org/manifest.json'
  });
</script>
```

## Configuration Options

The `Diva` constructor accepts a root element ID and an options object:

```javascript
const viewer = new Diva(rootElementId, options);
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `objectData` | `string` | (required) | URL to a IIIF manifest or collection |
| `acceptHeaders` | `string[]` | `[]` | Additional Accept headers for requests |
| `showSidebar` | `boolean` | `true` | Whether to show the sidebar by default |
| `showTitle` | `boolean` | `true` | Whether to show the manifest title |


## IIIF Support

Diva.js supports both IIIF Presentation API v2 and v3:

- **Manifests**: Full support for viewing manifests with canvases and annotations
- **Collections**: Browse and navigate collection hierarchies
- **Ranges**: Table of contents navigation via ranges/structures
- **Multiple images per canvas**: View and switch between multiple images on a single canvas

### Building from source

If you want to build Diva.js from source, you'll need Elm installed:

```bash
# Install Elm
npm install -g elm

# Clone the repository
git clone https://github.com/rism/Diva/diva.js.git
cd diva.js

# Build the project
elm make src/Main.elm --output=diva.js
```

## Next Steps

- [View examples](/examples/) to see Diva.js in action
- Explore the [API reference](/docs/api/) for advanced usage
- Learn about [image filters](/docs/filters/) for image processing
