# MVC-XQuery

[![version][version-badge]][CHANGELOG] [![license][license-badge]][LICENSE]

MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX

Copyright (C) 2018–2020 [Adam Steffanick](https://www.steffanick.com/adam/)

## Download
* [**Latest release**](https://github.com/AdamSteffanick/mvc-xquery/releases/latest)

## Documentation
### [BaseX]:
* Download this repository and place all files within the `webapp` subdirectory of `basex`
* Modify [model.xquery], [view.xquery], and [controller.xquery] as needed
* Run the [BaseX HTTP Server](http://docs.basex.org/wiki/Startup#HTTP_Server)
* Navigate to http://localhost:8984 in your browser

### Default output
#### html5:html()
```
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX</title>
  </head>
  <body>
    <h1>Hello, world!</h1>
  </body>
</html>
```

#### html5:html($bootstrap:template)
```
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  </head>
  <body>
    <h1>Hello, world!</h1>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"/>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"/>
  </body>
</html>
```

## Features
* [BaseX] 9.1.2 support
* [Bootstrap] v4.3.1 support
* [HTML5] v5.2 support
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
│   ├── bootstrap.xquery
│   ├── html5.xquery
│   └── mvc.xquery
│   └── tei.xquery
└── view.xquery

1 directory, 10 files
```

## Acknowledgments
MVC-XQuery derives from [Experiments with XQuery, RESTXQ, and MVC in BaseX](https://gist.github.com/CliffordAnderson/80c68ea43557446b8331) by [Clifford Anderson](https://github.com/CliffordAnderson) and my work with the members of the TEI, XQuery, Semantic Web, and Linked Data working groups at Vanderbilt University.

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

[CHANGELOG]: ./CHANGELOG.md
[version-badge]: https://img.shields.io/badge/mvc--xquery-v0.5.0-0038e2.svg?style=flat-square
[LICENSE]: ./LICENSE
[license-badge]: https://img.shields.io/badge/license-GPL-0038e2.svg?style=flat-square

[model.xquery]: ./model.xquery
[view.xquery]: ./view.xquery
[controller.xquery]: ./controller.xquery

[BaseX]: http://basex.org/
[Bootstrap]: https://getbootstrap.com/
[HTML5]: https://www.w3.org/TR/html52/
[TEI]: https://tei-c.org/guidelines/p5/