# MVC-XQuery

[![version][version-badge]][CHANGELOG] [![license][license-badge]][LICENSE]

MVC-XQuery | A Model-View-Controller framework for BaseX 

Copyright (C) 2018 [Adam Steffanick](https://www.steffanick.com/adam/)

## Download
* [**Latest release**](https://github.com/AdamSteffanick/mvc-xquery/releases/latest)

## Documentation
### BaseX 9.0.2:
* Download this repository and place all files within the appropriate subdirectories of `basex`
* Modify [model.xquery], [view.xquery], and [controller.xquery] as needed
* Run the [BaseX HTTP Server](http://docs.basex.org/wiki/Startup#HTTP_Server)
* Navigate to http://localhost:8984 in your browser

### Default output:
```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>MVC-XQuery | A Model-View-Controller framework for BaseX</title>
  </head>
  <body>
    <h1>Hello, world!</h1>
  </body>
</html>
```

## Features
* [Bootstrap] support

## Manifest tree
MVC-XQuery should contain:

```
mvc-xquery
├── CHANGELOG.md
├── LICENSE
├── README.md
└── webapp
    ├── controller.xquery
    ├── model.xquery
    ├── modules
    │   └── bootstrap.xquery
    └── view.xquery

2 directories, 7 files
```

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

[CHANGELOG]: ./CHANGELOG.md
[version-badge]: https://img.shields.io/badge/mvc--xquery-v0.2.0-0038e2.svg?style=flat-square
[LICENSE]: ./LICENSE
[license-badge]: https://img.shields.io/badge/license-GPL-0038e2.svg?style=flat-square

[model.xquery]: ./webapp/model.xquery
[view.xquery]: ./webapp/view.xquery
[controller.xquery]: ./webapp/controller.xquery

[Bootstrap]: https://getbootstrap.com/