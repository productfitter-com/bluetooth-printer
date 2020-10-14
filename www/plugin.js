
var exec = require('cordova/exec');

var PLUGIN_NAME = 'MyCordovaPlugin';

var MyCordovaPlugin = {
echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
},
doPrint: function(param, res, err) {
    exec(res, err, PLUGIN_NAME, 'doPrint', [param]);
},
getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
},
getPrinters: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'getPrinters', [phrase]);
},
getList: function(res, err) {
    exec(res, err, PLUGIN_NAME, 'getList', null);
}
};

module.exports = MyCordovaPlugin;
