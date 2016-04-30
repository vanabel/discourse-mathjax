discourse-mathjax
=================

Mathjax plugin for [Discourse](http://discourse.org).

I add some newcommend in `plugin.rb`
Installation
============

* Run `bundle exec rake plugin:install repo=https://github.com/vanabel/discourse-mathjax.git` in your discourse directory
* In development mode, run `bundle exec rake assets:clean`
* In production, recompile your assets: `bundle exec rake assets:precompile`
* Restart Discourse
