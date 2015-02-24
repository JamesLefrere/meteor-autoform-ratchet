Package.describe({
  name: "jameslefrere:autoform-ratchet",
  summary: "Ratchet theme for Autoform",
  version: "0.1.0",
  git: "https://github.com/JamesLefrere/meteor-autoform-ratchet.git"
});

Package.onUse(function(api) {
  api.versionsFrom("1.0.1");
  api.use(["templating", "coffeescript", "underscore", "less", "aldeed:autoform"], "client");
  api.addFiles(["autoform_ratchet.html", "autoform_ratchet.coffee", "autoform_ratchet.less"], "client");
});
