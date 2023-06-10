# Publishing

It is beyond the scope of this documentation to provide detailed information about publishing to various content delivery networks and web servers, but you may find the below example useful:


```console
$ RSPEC_DOCUMENTATION_URL_ROOT='/rspec-documentation' rspec-documentation
$ rsync --delete -r rspec-documentation/bundle/ docs01.bob.frl:/mnt/docs/rspec-documentation/
```

This command was used to publish the documentation you are currently reading to an _AWS EC2_ instance which is serving the content that you are reading now. You are welcome to view the [Terraform code](https://github.com/bobf/docs.bob.frl-terraform) that manages this infrastructure.

You can use any web host you like to serve this documentation since the build output is exclusively static _HTML_ plus a self-contained _Javascript_ and _CSS_ bundle. [Surge](https://surge.sh) is a good place to start if you are looking for a simple _CDN_ to get started with.
