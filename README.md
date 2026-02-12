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

### Local Development

Run the development server:

```bash
hugo server -D
```

The site will be available at http://localhost:1313/

### Building

Build the static site:

```bash
cd website
hugo
```

The output will be in the `public/` directory.

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the `gh-pages` branch. The deployment is handled by the GitHub Actions workflow in `.github/workflows/hugo.yml`.

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
