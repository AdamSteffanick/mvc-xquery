# MVC-XQuery

[![version][version-badge]][CHANGELOG] [![license][license-badge]][LICENSE]

MVC-XQuery | A Model-View-Controller framework for BaseX 

Copyright (C) 2018 [Adam Steffanick](https://www.steffanick.com/adam/)

## Download
* [**Latest release**](https://github.com/AdamSteffanick/mvc-xquery/releases/latest)

## Documentation
BaseX 9.0:

* Download this repository and place all files within the appropriate subdirectories of `basex`
* Modify [model.xquery], [view.xquery], and [controller.xquery] as needed
* Run the [BaseX HTTP Server](http://docs.basex.org/wiki/Startup#HTTP_Server)

## Manifest tree
The `mvc-xquery` directory should contain:

```
├── CHANGELOG.md
├── LICENSE
├── README.md
└── webapp
    ├── controller.xquery
    ├── model.xquery
    └── view.xquery

1 directory, 6 files
```

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

[CHANGELOG]: ./CHANGELOG.md
[version-badge]: https://img.shields.io/badge/mvc--xquery-v0.0.2-0038e2.svg?style=flat-square
[LICENSE]: ./LICENSE
[license-badge]: https://img.shields.io/badge/license-GPL-0038e2.svg?style=flat-square

[model.xquery]: ./webapp/model.xquery
[view.xquery]: ./webapp/view.xquery
[controller.xquery]: ./webapp/controller.xquery