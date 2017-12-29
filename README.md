# Base
A base application with GraphQL via Apollo, React, & Meteor.


## Getting started
```
$ meteor npm install
$ npm start
```

## Directory Structure
The app has two start-points: 
```
client
└── main.js
server
└── main.js

```

Everything within `imports/` has to be imported to get used.

```
/imports
├── graphql
├── startup          - startup files for client and server,
│                      by default we setup apollo-server and have an empty seeds file.
├── api              - the 'domain' of our application. database collections and business-logic goes here
│                      e.g. /api/posts.js may contain a posts Mongo collection. 
├── apollo
│   └── client.js    - the Apollo client, used in the UI to get data from the Apollo Server
│
├── graphql
│   ├── index.js       - exports the graphql stuff
│   ├── resolvers.js   - connects our schema to our data
│   └── schema.graphql - defines our schema
│
└── ui
  ├── Root.js        - the root component, the app starts here.
  ├── components     - React components that are used within pages
  ├── helpers.js     - A collection of UI helpers. `withLoading` and `logProps` come for free.
  ├── pages          - React components that contain a whole page
  └── styles         - the scss files, imported through main.scss
```
