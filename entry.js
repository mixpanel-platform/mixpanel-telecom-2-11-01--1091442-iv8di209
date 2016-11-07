// Stylesheets
require('normalize.css');
require('stylus/app');
// Add content to HTML
var content = require('jade/content.jade')();
$('body').html(content);
require('coffeescript/app');
