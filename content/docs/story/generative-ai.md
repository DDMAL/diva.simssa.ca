---
title: "Continued Development and Generative AI"
description: "Stalls, inspiration, and the use of AI"
weight: 2
---

Although public development stalled in 2019, private development continued. There were around six or seven (depending on how you counted) different versions, candidates, proofs-of-concept, and other developments that have never seen the light of day.

The problem was that, after more than a decade of development, and a number of different developers, the code base had gotten to the point where it was difficult to make any changes without breaking it. 

One of the core problems was state management. Diva.js started as a single file, and then grew into a compiled set of interdependent modules. There was a central state object (actually there were at least two!) but each component could also change the shared state. This meant that moving things around in one place was likely to break it in three other places. 

In addition, the rendering and layout component needed an overhaul. From the start, Diva.js used a custom renderer (most other IIIF viewers use OpenSeadragon), at first because no other option existed, and later because we wanted to keep the scrolling document UI which was difficult to do with OpenSeadragon (more on this in a moment...). So we rolled our own, but bugs were starting to show and the animations and other interactions with the images were not as smooth as we would like them.

Finally, I had a goal to build a fairly advanced image manipulation suite into Diva.js. The Digital Image Archive of Medieval Music (DIAMM) website uses Diva.js as the image viewer, and the images on that site can sometimes benefit from image manipulation tools to make degraded page images more readable. I wanted to take it one step further and try and build some filters that would work for heavily degraded images. 

So there were three goals I set myself for a new version of Diva.js:
 
 - Better UI state management. No more "spooky action at a distance"
 - A new rendering engine, but keeping the scrolling UI interaction
 - More image filters

Every six months or so I would pick up development for a bit, spurred on by some sort of change or new knowledge. There are unreleased versions that used the browser Intersection Observer for scrolling. Some that built in a comprehensive image suite with advanced filters. A 95% complete port of the current version to TypeScript. Yet nothing seemed like it was at the state where I would be happy releasing it.

## Unlocking the next version with AI

Fast-forward to January 2026. I decided to give OpenAI Codex a try and needed a project. At first, I tried giving it the original Diva.js codebase to see if it could help me fix it, but this quickly went off the rails.

So I decided I would try a new "Proof-of-Concept" to see whether AI could help me take OpenSeadragon and build in the scrolling image interface. I intended this as just an experiment, but after about 30 minutes I had a working demo. Codex "unlocked" a smooth-scrolling image viewing UI using OpenSeadragon -- my main blocker for the past seven years. From that point on, adding new features seemed to come naturally. Within a week (not full-time) I got it to the point where I decided that it would be the next version of Diva.js. 

Development, even with AI, still seems to follow the 80/20 rule. Several weeks passed as I developed and reviewed the AI-written code, worked to optimize the UI, created build systems, styling, structure, documentation, etc. While AI did most of the code writing, I reviewed and tested the changes. Then came the administration of the release: repo re-organization, building a website -- all the usual bits and bobs.

I also built [elm-iiif](https://package.elm-lang.org/packages/rism-digital/elm-iiif/latest/), a separate component that provides the core of the IIIF manifest decoding. I had already built large parts of this several years ago as part of a previously unreleased version, so I brought that in and enhanced it.

For the image filters, some were brought in from existing JavaScript toolkits, while others were designed in collaboration with AI.

## Inspiration

In the intervening years, several projects have served as the inspiration for new ideas in Diva.js. I learned the [Elm programming language](https://elm-lang.org), a functional language that compiles to JavaScript. It has immutable state, strong type safety, and claims (almost) zero runtime errors (a fact I can attest to). It is the basis of the new UI and the core of the new Diva.js viewer.

For the image filters, I had previously prototyped building the ones from [CamanJS](https://camanjs.phamthanh.me/examples/) in Diva.js. The filters from the [OpenSeadragon Filtering project](https://github.com/usnistgov/OpenSeadragonFiltering) were also used and enhanced. Presentations from the [Archimedes Palimpsest](https://www.archimedespalimpsest.org/about/imaging/processing.php) on what you can do with image processing to restore degraded images, as well as the work done by Julia Craig-McFeely on the [San Lorenzo Palimpsest](https://www.diamm.ac.uk/resources/musres/digital-retrieval/), both served to inspire the design of some of the more advanced image filters.

A long-forgotten demo for a ["Mirador 2"](https://github.com/openseadragon/openseadragon/tree/master/test/demo/m2) unrealized development path served to illustrate that a scrolling page UI was possible with OpenSeadragon if only I could figure out the co-ordinate system.

I led technical design and development for the custom image viewer built into [Digital Bodleian](https://digital.bodleian.ox.ac.uk). Several components of the new Diva.js viewer are heavily inspired from this work.

The [Jalava Image Viewer](https://iiif.durham.ac.uk/jalava/universe.html) and, particularly, the Collection Browser, is a brilliant piece of work. It served as one of the sources of inspiration to learn the Elm language, and I have always appreciated the tree-browsing approach to viewing IIIF collections.

