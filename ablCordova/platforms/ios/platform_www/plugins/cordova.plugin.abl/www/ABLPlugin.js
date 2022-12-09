cordova.define("cordova.plugin.abl.ABLPlugin", function(require, exports, module) {
var exec = require("cordova/exec");

// exports.coolMethod = function (arg0, success, error) {
//     exec(success, error, 'ABLPlugin', 'coolMethod', [arg0]);
// };

exports.startFlow = function (success, error) {
  exec(success, error, "ABLPlugin", "startFlow", []);
};

});
