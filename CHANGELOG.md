# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.5.0] - 2020-01-01
### Added
* [tei.xquery]
* `mvc:minify` ([mvc.xquery])
* `mvc-tei:dispatch` ([tei.xquery])
* `mvc-tei:passthru` ([tei.xquery])
* `mvc-tei:w` ([tei.xquery])
* `mvc-tei:s` ([tei.xquery])
* `mvc-tei:seg` ([tei.xquery])
* `mvc-tei:p` ([tei.xquery])
* `mvc-tei:bibl` ([tei.xquery])
* `mvc-tei:ref` ([tei.xquery])
* `mvc-tei:quote` ([tei.xquery])
* `mvc-tei:q` ([tei.xquery])
* `mvc-tei:hi` ([tei.xquery])
* `mvc-tei:mark` ([tei.xquery])
* `mvc-tei:pb` ([tei.xquery])
* `mvc-tei:lb` ([tei.xquery])
* `mvc-tei:body` ([tei.xquery])

## [0.4.0] - 2019-03-25
### Added
* [mvc.xquery]
* `$mvc:brand` ([mvc.xquery])
* `$mvc:brand-description` ([mvc.xquery])
* `$mvc:paths` ([mvc.xquery])
* `$mvc:template` ([mvc.xquery])
* `$mvc:title` ([mvc.xquery])
* `$mvc:version` ([mvc.xquery])
* `mvc:list-paths()` ([mvc.xquery])

### Changed
* [Bootstrap] → v4.3.1 ([bootstrap.xquery])
* `html5:html-refine()` ([html5.xquery]) → `mvc:html-refine()` ([mvc.xquery])
* refactored `bootstrap:navbar-brand()` ([bootstrap.xquery])
* refactored `bootstrap:navbar-search()` ([bootstrap.xquery])
* refactored `bootstrap:navbar-ul()` ([bootstrap.xquery])
* refactored `html5:html()` ([html5.xquery])
* refactored `html5:title()` ([html5.xquery])

## [0.3.0] - 2019-02-26
### Added
* [html5.xquery]
* `html5:element()` ([html5.xquery])
* `m:home()` ([model.xquery])

### Changed
* `m:html5()` ([model.xquery]) → `html5:html()` ([html5.xquery])
* `m:html5-base()` ([model.xquery]) → `html5:base()` ([html5.xquery])
* `m:html5-body()` ([model.xquery]) → `html5:body()` ([html5.xquery])
* `m:html5-filter()` ([model.xquery]) → `html5:html-filter()` ([html5.xquery])
* `m:html5-head()` ([model.xquery]) → `html5:head()` ([html5.xquery])
* `m:html5-head-meta()` ([model.xquery]) → `html5:meta-priority()` ([html5.xquery])
* `m:html5-link()` ([model.xquery]) → `html5:link()` ([html5.xquery])
* `m:html5-lang()` ([model.xquery]) → `html5:lang()` ([html5.xquery])
* `m:html5-meta()` ([model.xquery]) → `html5:meta()` ([html5.xquery])
* `m:html5-noscript()` ([model.xquery]) → `html5:noscript()` ([html5.xquery])
* `m:html5-refine()` ([model.xquery]) → `html5:html-refine` ([html5.xquery])
* `m:html5-script()` ([model.xquery]) → `html5:script()` ([html5.xquery])
* `m:html5-style()` ([model.xquery]) → `html5:style()` ([html5.xquery])
* `m:html5-template()` ([model.xquery]) → `html5:template()` ([html5.xquery])
* `m:html5-title()` ([model.xquery]) → `html5:title()` ([html5.xquery])

## [0.2.3] - 2019-02-18
### Added
* `bootstrap:navbar-search()` @param `$parameter` ([bootstrap.xquery])

### Fixed
* `m:html5-body` empty sequence bug ([model.xquery])
* `m:html5-head` empty sequence bug ([model.xquery])
* refactored `m:html5-refine()` ([model.xquery])

## [0.2.2] - 2019-02-15
### Added
* `$bootstrap:template` ([bootstrap.xquery])
* `m:html5-refine()` ([model.xquery])

### Changed
* [Bootstrap] → v4.2.1 ([bootstrap.xquery])
* all functions & variables → `%public` or `%private`
* `m:html5()` @param `$parameter as map(*)?` → `$parameter as map(*)+` ([model.xquery])

## [0.2.1] - 2019-02-11
### Changed
* /webapp/modules/ → [/modules/]
* [model.xquery] → /
* [view.xquery] → /
* [controller.xquery] → /

### Removed
* /webapp/

## [0.2.0] - 2018-09-25
### Added
* /webapp/modules/
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
* /webapp/
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

[Unreleased]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.2.3...v0.3.0
[0.2.3]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.0.2...v0.1.0
[0.0.2]: https://github.com/AdamSteffanick/mvc-xquery/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/AdamSteffanick/mvc-xquery/compare/1967830...v0.0.1
[Initial commit]: https://github.com/AdamSteffanick/mvc-xquery/commit/19678309320771cd968dbfea2f8f8582d5dc0de6

[CHANGELOG.md]: ./CHANGELOG.md
[LISENCE]: https://github.com/AdamSteffanick/mvc-xquery/blob/master/LICENSE
[README.md]: ./README.md

[controller.xquery]: ./controller.xquery
[model.xquery]: ./model.xquery
[view.xquery]: ./view.xquery

[/modules/]: ./modules/
[bootstrap.xquery]: ./modules/bootstrap.xquery
[html5.xquery]: ./modules/html5.xquery
[mvc.xquery]: ./modules/mvc.xquery
[tei.xquery]: ./modules/tei.xquery

[Bootstrap]: https://getbootstrap.com/
[shields.io]: http://shields.io/