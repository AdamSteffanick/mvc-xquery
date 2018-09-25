# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.2.0] - 2018-09-25
### Added
* [/webapp/modules/]
* [bootstrap.xquery]
* `bootstrap:card()` ([bootstrap.xquery])
* `bootstrap:card-layout()` ([bootstrap.xquery])
* `bootstrap:container()` ([bootstrap.xquery])
* `bootstrap:javascript()` ([bootstrap.xquery])
* `bootstrap:list-group()` ([bootstrap.xquery])
* `bootstrap:meta()` ([bootstrap.xquery])
* `bootstrap:navbar()` ([bootstrap.xquery])
* `bootstrap:navbar-brand()` ([bootstrap.xquery])
* `bootstrap:navbar-ul()` ([bootstrap.xquery])
* `bootstrap:navbar-search()` ([bootstrap.xquery])
* `bootstrap:stylesheet()` ([bootstrap.xquery])

## [0.1.1] - 2018-06-07
### Changed
* `m:html5()` @param `$options` → `$parameter` ([model.xquery])
* `m:html5-body()` @param `$parameter as item()*` → `$parameter as map(*)?` ([model.xquery])
* `m:html5-head()` @param `$parameter as item()*` → `$parameter as map(*)?` ([model.xquery])

### Removed
* `m:html5()` @param `$body` ([model.xquery])
* `m:html5()` @param `$head` ([model.xquery])
* `m:html5-body()` @param `$options` ([model.xquery])
* `m:html5-head()` @param `$options` ([model.xquery])

## [0.1.0] - 2018-04-06
### Added
* `c:home()` ([controller.xquery])
* `m:html5()` ([model.xquery])
* `m:html5-base()` ([model.xquery])
* `m:html5-body()` ([model.xquery])
* `m:html5-filter()` ([model.xquery])
* `m:html5-head()` ([model.xquery])
* `m:html5-head-meta()` ([model.xquery])
* `m:html5-link()` ([model.xquery])
* `m:html5-meta()` ([model.xquery])
* `m:html5-noscript()` ([model.xquery])
* `m:html5-title()` ([model.xquery])
* `m:html5-script()` ([model.xquery])
* `m:html5-style()` ([model.xquery])
* `m:html5-template()` ([model.xquery])
* `m:html5-lang()` ([model.xquery])
* `v:html()` ([view.xquery])

## [0.0.2] - 2018-04-03
### Added
* [/webapp/]
* [model.xquery]
* [view.xquery]
* [controller.xquery]

## [0.0.1] - 2018-04-02
### Added
* [CHANGELOG.md]
* [shields.io] lisence info ([README.md])
* [shields.io] version info ([README.md])

## [Initial commit]
### Added
* [LISENCE]
* [README.md]

[Unreleased]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.0.2...v0.1.0
[0.0.2]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/AdamSteffanick/mvc-xquery/compare/1967830...v0.0.1
[Initial commit]: https://github.com/AdamSteffanick/mvc-xquery/commit/19678309320771cd968dbfea2f8f8582d5dc0de6

[CHANGELOG.md]: ./CHANGELOG.md
[LISENCE]: https://github.com/AdamSteffanick/mvc-xquery/blob/master/LICENSE
[README.md]: ./README.md

[/webapp/]: ./webapp/
[/webapp/modules/]: ./webapp/modules/
[model.xquery]: ./webapp/model.xquery
[view.xquery]: ./webapp/view.xquery
[controller.xquery]: ./webapp/controller.xquery
[bootstrap.xquery]: ./webapp/modules/bootstrap.xquery

[shields.io]: http://shields.io/