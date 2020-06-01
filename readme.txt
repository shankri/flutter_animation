1. npm install firebase tools
  npm install -g firebase-tools
2. firebase login
3. firebase init
  - this is run in 'build' folder
  - 'web' directory instead of 'public' directory
  - 'y' for single page application
  - 'n' to override default index.html
4. after 'firebase init' open firebase.json (under build folder) and add "site": "flutteranim"
  - note: 'flutteranim' is where it will deploy the app
5. firebase deploy --only hosting:flutteranim



https://flutteranim.web.app/#/