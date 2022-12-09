cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova.plugin.abl.ABLPlugin",
      "file": "plugins/cordova.plugin.abl/www/ABLPlugin.js",
      "pluginId": "cordova.plugin.abl",
      "clobbers": [
        "cordova.plugins.ABLPlugin"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-whitelist": "1.3.5",
    "cordova.plugin.abl": "0.1"
  };
});