# Documentation Bundle

A documentation bundle containing static _HTML_ and a minified _Javascript_ / _CSS_ bundle is created inside your `rspec-documentation/` directory every time you run the `rspec-documentation` command.

It is recommended to add this `rspec-documentation/bundle/` to `.gitignore`, depending on your deployment setup.

The bundle can be deployed to any web server and has no dependencies on any system services, making it ideal for popular _CDN_ services like [Surge.sh](https://surge.sh/).

See [Build Paths documentation](../configuration/build-paths.html) for details on deploying the documentation bundle to a subdirectory (i.e. when you are not hosting your documentation at the root path of your web server).
