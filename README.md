# Diva.js Website

This is the source for the Diva.js documentation website, built with [Hugo](https://gohugo.io/).

## Development

### Prerequisites

Install Hugo (extended version recommended):

```bash
# macOS
brew install hugo

# Or download from https://gohugo.io/installation/
```

Install Node.js 24 and the locked API documentation dependencies:

```bash
yarn install --frozen-lockfile
```

### Local Development

Run the development server:

```bash
yarn docs:api:local
hugo server -D
```

The site will be available at http://localhost:1313/

The local API command generates documentation from the sibling `../diva.js` checkout into an ignored static directory, making it available at http://localhost:1313/docs/api/ without publishing Diva.js to npm.

### Building

Build the static site:

```bash
hugo
yarn docs:api
```

The Hugo site and the generated API reference will be in the `public/` directory. The API reference is available at `/docs/api/`.

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the `main` branch. The deployment is handled by the GitHub Actions workflow in `.github/workflows/hugo.yml`.

## Structure

```
website/
├── archetypes/     # Content templates
├── content/        # Markdown content
│   ├── docs/       # Documentation pages
│   └── examples/   # Example implementations
├── layouts/        # HTML templates
│   ├── _default/   # Default templates
│   ├── partials/   # Reusable template parts
│   └── index.html  # Home page template
├── static/         # Static assets (CSS, JS, images)
└── hugo.toml       # Hugo configuration
```

## Adding Content

### New documentation page

```bash
hugo new docs/my-page.md
```

### New example

```bash
hugo new examples/my-example.md
```

Edit the generated file and set `draft: false` when ready to publish.

## Updating the API Reference

The API reference is generated from the exact `diva.js` version pinned in `package.json`. When updating the website for a new Diva.js release:

1. Update the `diva.js` version in `package.json` after that version is published to npm.
2. Run `yarn install` to update `yarn.lock`.
3. Update the website's bundled Diva.js files in the same commit.
4. Run `hugo` followed by `yarn docs:api` and inspect `public/docs/api/` locally.

Generated files under `public/` are build artifacts and are not committed.

## Preparing Homepage Videos

Keep raw `.mov` sources in the ignored `sources/videos/` directory. Generate the published WebM, MP4, and poster assets with:

```bash
scripts/prepare-videos.sh
```

Only the optimized files under `static/videos/web/` are published by Hugo.
