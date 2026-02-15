---
title: "History"
description: "A short history of Diva.js"
weight: 6
---

(Adapted and expanded from the [Code4Lib article](https://journal.code4lib.org/articles/5418) on Diva.js)

Diva began in 2008 as part of a project by the Swiss working group for the Répertoire International des Sources Musicale (RISM) project. The Swiss working group for the RISM project was granted funding for an exploratory project in digitizing musical sources (prints and manuscripts) from Swiss composers held in libraries and monasteries across Switzerland.

At the beginning of this exploratory project, a partnership between the Swiss RISM and the Distributed Digital Music Libraries Laboratory (DDMAL) at the Schulich School of Music of McGill University was tasked with identifying the tools and interfaces that would be used for displaying digitized document images in a web browser. To identify the current “state of the art” we conducted a survey of 24 digital libraries. Based on this survey, we identified a list of functional requirements that we wanted in a document image viewer that was specifically designed for displaying musical sources.

The result of our survey was that no currently-available open-source tool was available that provided us with the type of document image viewing interface that we wanted. So we decided to build one.

## Towards Diva.js

Our first document viewer was written as a component to a larger ExtJS interface for managing digital images, part of an in-house image system for the Swiss RISM. It was not released publicly, but it has been adopted by a number of other projects related to the RISM.

<figure class="video-figure">
 <video controls preload="metadata" width="80%" poster="/videos/scores_poster_frame.jpg">
    <source src="/videos/presentation_viewing_scores.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>
<figcaption>The original Swiss DocumentViewer in 2009</figcaption>
</figure>

While the ExtJS component worked very well, it required loading the entire ExtJS library, including superfluous components, which added significantly to the loading time for pages. The decision was made to port the image viewer component to jQuery, a widely used JavaScript framework that is smaller and more modular in design, with faster load and execution time than ExtJS.

Development on the jQuery plugin began in February 2011, using the same design requirements as the original ExtJS component. It was officially named "diva.js" on March 24, 2011, and the 1.0 release was on June 6, 2011. (Diva stood for "Document Image Viewer with AJAX".)

## How diva.js worked (Pre-IIIF)

There were two back-end components, and a front-end viewer. The image server (we used IIP Image Server) was responsible for delivering tiled images using the Internet Image Protocol. The data server was responsible for sending a JSON document to the image viewer. Those who are familiar with the IIIF Manifest, it was a similar concept, although it contained much more information about the image sizes, zoom levels, and tile sizes. 

The front-end viewer used the JSON data, provided as an HTTP URL. It would use the data to build a page in the browser that was optimized for viewing large documents. The viewer would "lazy load" the pages and the tiles, requesting only the parts of the document that were currently being viewed by the user. Users could "zoom" in and out from the images, viewing high-resolution images without needing to first download large image files.

## IIIF Support and Continued Development

On September 9, 2015 we released Diva.js 5.0, featuring IIIF support. This coincided with our work, through the [SIMSSA project](https://simssa.ca), on distributed Optical Music Recognition. Over the next few years, work on Diva.js continued apace. Diva.js 6.0 was released in 2018, and a few patch releases followed. Ultimately, however, development stalled (publicly, at least) in 2019.

## Publications

Hankinson, A., L. Pugin, G. Hanke Knaus, and I. Fujinaga. 2008. Web-based musical document viewer for digital music libraries. 9th International Conference on Music Information Retrieval (ISMIR 2008), Philadelphia, PA.

Hankinson, A., L. Pugin, and I. Fujinaga. 2009. Interfaces for document representation in digital music libraries. In Proceedings of the 10th International Society for Music Information Retrieval Conference (ISMIR 2009), pp. 39–44. Kobe, Japan.

Pugin, L., and A. Hankinson. 2009. Building a comprehensive digital library for nineteenth-century Swiss composers. International Association of Music Libraries Conference (IAML), Amsterdam.

Hankinson, A., W. Liu, L. Pugin, and I. Fujinaga. 2011. Diva.js: A Continuous Document Viewing Interface. Code4Lib Journal, Issue 4.

Hankinson, A., W. Liu, L. Pugin, and I. Fujinaga. 2012. Diva: A Web-Based High-Resolution Digital Document Viewer. In: Zaphiris, P., Buchanan, G., Rasmussen, E., Loizides, F. (eds) Theory and Practice of Digital Libraries. TPDL 2012. Lecture Notes in Computer Science, vol 7489. Springer, Berlin, Heidelberg.

Hankinson, A. 2014. Optical music recognition infrastructure for large-scale music document analysis. Ph.D. diss. McGill University.

Hankinson, A., L. Pugin and I. Fujinaga. 2014. Accessing, navigating, and engaging with high-resolution document image collections using Diva.js. In Proceedings of the Digital Humanities Conference 2014. Lausanne, Switzerland.

Hankinson, A., E. Magoni, and I. Fujinaga. 2015. Decentralized Music Document Image Searching with Optical Music Recognition and the International Image Operability Framework. In Proceedings of the Digital Library Federation Forum. Vancouver, BC.
