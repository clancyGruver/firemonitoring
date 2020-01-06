const mix = require('laravel-mix');

mix.js('resources/js/app.js', 'public/js')
   .sass('resources/sass/app.scss', 'public/css');

mix.options({
   hmrOptions: {
         host: 'localhost',  // site's host name
         port: 5000,
   }
});

// // fix css files 404 issue
mix.webpackConfig({
   // add any webpack dev server config here
   devServer: { 
         proxy: {
            host: '127.0.0.1',  // host machine ip 
            port: 8080,
         },
         watchOptions:{
            aggregateTimeout:200,
            poll:5000
         },

   }
});