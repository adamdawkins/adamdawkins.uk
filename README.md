# CSS
We're not using the traditional Meteor CSS minifier or anything. 

I wanted to use [PostCSS](http://postcss.org) because, I've liked it for a while (using the _next_ CSS rather than a pre-processor feels right, and the _tiny_ new library [Lit](https://ajusa.github.io/lit/) (407 bytes gzipped) uses it as well, which allows me to use the source file instead of the dist.

The Meteor package for PostCSS, `juliancwirko:postcss` is [no longer maintained](https://github.com/juliancwirko/meteor-postcss/blob/master/README.md), so here's what we're doing.

## Directory Structure
The Meteor app is inside `app`, but `package.json` and `.git` etc are at the top-level. All scripts (e.g. `npm start` need to `cd app;` at the start to work with the Meteor app.)

All CSS is inside `/app/imports/styles`. Meteor will ignore these files unless they're explicitly imported, so we're good. 

The `/public` directory in Meteor is one Meteor leaves as is, so our `gulp` task will look for changes in `/app/imports/styles` and port the compiled files (made compatible with PostCSS and minified, there).

## Negatives
* It's not how stuff works in Meteor normally, and you (I) might be tempted to import files from `/imports/styles` and cause problems.
* We're doing things manually, e.g. file concatenation, but it _should_ be a simple site to style, so get over it.

## Positives
* We can use real postcss stuff as much as we want.
* Because we do Server-side Rendering, linking to these css files in `/client/main.html` means they can be automatically copied to the `<head>` of the server-side render too.
