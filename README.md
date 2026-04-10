# MVC-XQuery

[![version][version-badge]][CHANGELOG] [![license][license-badge]][LICENSE]

MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX

Copyright (C) 2018–2026 [Adam Steffanick](https://www.steffanick.com/adam/)

## Download
* [**Latest release**](https://github.com/AdamSteffanick/mvc-xquery/releases/latest)

## Documentation
### [BaseX]:
* Download this repository and place all files within the `webapp` subdirectory of `basex`
* Modify [model.xquery], [view.xquery], and [controller.xquery] as needed
* Run the [BaseX HTTP Server](https://docs.basex.org/main/Startup#HTTP_Server)
* Navigate to http://localhost:8080 in your browser

### Default output
```
<!DOCTYPE HTML>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX</title>
  </head>
  <body>
    <h1>Hello, world!</h1>
  </body>
</html>
```

## Features
* [BaseX] 12.2 support
* [HTML] support
* [TEI] P5 support

## Manifest tree
MVC-XQuery should contain:

```
mvc-xquery
├── CHANGELOG.md
├── LICENSE
├── README.md
├── controller.xquery
├── model.xquery
├── modules
│   └── mvc.xquery
│   └── tei.xquery
└── view.xquery

1 directory, 8 files
```

## Development workflow
We use a long-lived `develop` branch for all ongoing work and continuous development.

* All new features, bug fixes, and updates are made directly on `develop`.
* `main` is protected and always contains the latest stable release.
* When a release is ready, we open a single Pull Request from `develop` → `main`.
* Releases follow [Semantic Versioning](https://semver.org/) and include updated changelog notes.

## Acknowledgments
MVC-XQuery derives from [Experiments with XQuery, RESTXQ, and MVC in BaseX](https://gist.github.com/CliffordAnderson/80c68ea43557446b8331) by [Clifford Anderson](https://github.com/CliffordAnderson) and my work with the members of the TEI, XQuery, Semantic Web, and Linked Data working groups at Vanderbilt University.

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

[CHANGELOG]: ./CHANGELOG.md
[version-badge]: https://img.shields.io/badge/mvc--xquery-v0.6.0-0038e2.svg?style=flat-square
[LICENSE]: ./LICENSE
[license-badge]: https://img.shields.io/badge/license-GPL-0038e2.svg?style=flat-square

[model.xquery]: ./model.xquery
[view.xquery]: ./view.xquery
[controller.xquery]: ./controller.xquery

[BaseX]: http://basex.org/
[HTML]: https://html.spec.whatwg.org/multipage/
[TEI]: https://tei-c.org/guidelines/p5/