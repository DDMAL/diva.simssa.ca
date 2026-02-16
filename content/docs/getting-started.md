---
title: "Getting Started"
description: "How to set up Diva.js in your project"
weight: 1
---

## Including the required libraries

Include the OpenSeadragon and Diva.js script in your HTML:

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/5.0.1/openseadragon.min.js"></script>
<script src="path/to/diva.js"></script>
```

All CSS and images are included in the bundle, so there is nothing else to load.

## Basic Usage

To embed Diva.js in your page, create a container element and initialise the viewer:

```html
<div id="diva-wrapper"></div>

<script>
  const viewer = new Diva('diva-wrapper', {
    objectData: 'https://example.org/manifest.json'
  });
</script>
```

You should also ensure you have a style for the container you are using, e.g.,:

```css
#diva-wrapper {
    display: flex;
    height: 80vh;
    width: 100%;
}
```

The exact contents will vary depending on your specific embedding requirements.


## Configuration Options

The `Diva` constructor accepts a root element ID and an options object:

```javascript
const viewer = new Diva(rootElementId, options);
```

| Option          | Type       | Default    | Description                                           |
|-----------------|------------|------------|-------------------------------------------------------|
| `objectData`    | `string`   | (required) | URL to a IIIF manifest or collection                  |
| `acceptHeaders` | `string[]` | `[]`       | Additional Accept headers for requests                |
| `showSidebar`   | `boolean`  | `true`     | Whether to show the sidebar by default                |
| `showTitle`     | `boolean`  | `true`     | Whether to show the manifest title                    |
| `setLanguage`   | `string`   | `null`     | Override the auto-detected language with a set value. |


`setLanguage` is evaluated against the browser ["Navigator language"](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/language) property
and should match the language subtag component of the [BCP-47 string](https://developer.mozilla.org/en-US/docs/Glossary/BCP_47_language_tag). Thus
for `ar-Latn`, use `ar`; for `fr-CA` use `fr`, etc.

## IIIF Support

Diva.js supports both IIIF Presentation API v2 and v3:

- **Manifests**: Full support for viewing manifests with canvases and annotations
- **Collections**: Browse and navigate collection hierarchies
- **Ranges**: Table of contents navigation via ranges/structures
- **Multiple images per canvas**: View and switch between multiple images on a single canvas
