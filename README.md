# MVC-XQuery

[![version][version-badge]][CHANGELOG] [![license][license-badge]][LICENSE]

MVC-XQuery | A Model-View-Controller framework for BaseX 

Copyright (C) 2018–2019 [Adam Steffanick](https://www.steffanick.com/adam/)

## Download
* [**Latest release**](https://github.com/AdamSteffanick/mvc-xquery/releases/latest)

## Documentation
### BaseX 9.1.2:
* Download this repository and place all files within the `webapp` subdirectory of `basex`
* Modify [model.xquery], [view.xquery], and [controller.xquery] as needed
* Run the [BaseX HTTP Server](http://docs.basex.org/wiki/Startup#HTTP_Server)
* Navigate to http://localhost:8984 in your browser

### Default output
#### `html5:html()`
```
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>MVC-XQuery | A Model-View-Controller framework for BaseX</title>
  </head>
  <body>
    <h1>Hello, world!</h1>
  </body>
</html>
```

#### `html5:html($bootstrap:template)`
```
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>MVC-XQuery | A Model-View-Controller framework for BaseX</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  </head>
  <body>
    <h1>Hello, world!</h1>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"/>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"/>
  </body>
</html>
```

## Features
* [Bootstrap] v4.2.1 support
* [HTML5] v5.2 support

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
│   └── html5.xquery
└── view.xquery

1 directory, 8 files
```

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

[CHANGELOG]: ./CHANGELOG.md
[version-badge]: https://img.shields.io/badge/mvc--xquery-v0.3.0-0038e2.svg?style=flat-square
[LICENSE]: ./LICENSE
[license-badge]: https://img.shields.io/badge/license-GPL-0038e2.svg?style=flat-square

[model.xquery]: ./model.xquery
[view.xquery]: ./view.xquery
[controller.xquery]: ./controller.xquery

[Bootstrap]: https://getbootstrap.com/
[HTML5]: https://www.w3.org/TR/html52/