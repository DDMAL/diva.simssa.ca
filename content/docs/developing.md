---
title: "Developing"
description: "Diva.js internals and how it's built"
weight: 4
---

Diva.js is built from two main pieces: an Elm application that manages state and UI, and a TypeScript layer that provides the custom OpenSeadragon viewer element and bridges Elm ports to the browser.

## Architecture Overview

- **Elm UI and state**: The core UI, layout, and IIIF manifest parsing live in Elm. It handles view state (scrolling layout, page view, sidebars, contents, metadata) and sends commands to the viewer through ports.
- **TypeScript glue**: `src/diva.ts` initializes the Elm app, wires ports, injects styles, and manages the OpenSeadragon instance in Page View.
- **OpenSeadragon**: The custom element `src/viewer-element.ts` wraps OpenSeadragon and implements the scrolling and multi-page. Elm signals page and layout changes; the element reports back the zoom and page changes.
- **Filters pipeline**: Filters are defined in Elm for the UI and in TypeScript for applying them to the OpenSeadragon tiles. Page View provides a filtered, zoomable image with export capability.

Key source files:

- `src/Main.elm`: app entry point, subscriptions, update loop, ports.
- `src/View/*.elm`: UI for the main viewer, sidebars, and modals.
- `src/viewer-element.ts`: the `osd-viewer` custom element and scroll layout logic.
- `src/diva.ts`: Elm/TS integration and viewer wiring.
- `src/filters.ts`: filter application and configuration helpers.

## Key Technologies

- **Elm** for stateful UI and IIIF model logic.
- **TypeScript** for browser integration and OpenSeadragon control.
- **OpenSeadragon** for tiled image loading and deep zoom.
- **esbuild** for bundling the TypeScript + Elm output.
- **lightningcss** for bundling and minifying the CSS. 

## elm-iiif

At the core of the manifest parsing is the elm-iiif package. This was built specifically for the new verion of Diva.js, but has been released as a separate package so that others can use it.

By building type-safe JSON decoders, it is less likely that non-compliant manifests will produce undefined behaviour. Most likely, a manifest that does not conform to the standard will fail
to parse, and will refuse to load in the viewer. Some leeway is built in, but for the most part, IIIF response parsing is very strict in Diva.js.

The elm-iiif package also contains parsers and helpers for working with IIIF Image API URLs. For example, it contains type-safe constructors for the various parameters that can make up a
IIIF Image API URL, and will use these values to build valid Image API URLs.

More information can be found on the [Elm packages site](https://package.elm-lang.org/packages/rism-digital/elm-iiif/latest/). 

## Development Setup

Prerequisites:

- Node.js + Yarn
- make
- Elm (for building the Elm source)
- elm-format (for code formatting)
- elm-review (for checking the Elm coding style)

Install dependencies:

```bash
yarn install
```

The Elm dependencies (in `elm.json`) will automatically install when the package is built the first time.

## Building

The production bundle can be built with Make.  

```bash
make clean && make build
```

This command will create the `build/diva.js` file, which is minified and stripped of any debugging information.

We also ship a debug build that can help track down integration problems. 

```bash
make build-dev
```

This command will create `build/diva.debug.js`, which you can load in place of `diva.js`. It will give you access to the Elm "time travel debugger" to see the internal state of the application.

You can also watch for changes and re-build the debug build as you develop.

```bash
yarn run develop
```

It is probably helpful to run a local web server as you develop.

```bash
python3 -m http.server 8000
```

Then open:

- `http://localhost:8000/testing/testing.html` for the development test harness.
- `http://localhost:8000/testing/index.html` for the basic example.

## Formatting

We have a weird thing with using Allman style in the TypeScript files. To reformat the TypeScript we use `clang-format`, and this can be invoked with `yarn`:

```bash
yarn run format
```

There is also an elm-review configuration, which should be checked for any violations:

```bash
elm-review
```

