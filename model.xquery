xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery model function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework for BaseX
 : Copyright (C) 2018–2019 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.3.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : February 26, 2019
 : @since v0.0.2
 :
 : This program is free software: you can redistribute it and/or modify
 : it under the terms of the GNU General Public License as published by
 : the Free Software Foundation, either version 3 of the License, or
 : (at your option) any later version.
 :
 : This program is distributed in the hope that it will be useful,
 : but WITHOUT ANY WARRANTY; without even the implied warranty of
 : MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 : GNU General Public License for more details.
 :
 : You should have received a copy of the GNU General Public License
 : along with this program. If not, see <https://www.gnu.org/licenses/>.
 :
 : LICENSE: GNU General Public License
 : @see: https://github.com/AdamSteffanick/mvc-xquery/blob/master/LICENSE
 :)
module namespace m = "model";

(: required function library modules :)
import module namespace html5 = "html5" at "modules/html5.xquery";

(: optional function library modules :)
import module namespace bootstrap = "bootstrap" at "modules/bootstrap.xquery";

(:~
 : A function to return an HTML5 home page.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.3.0
 :
 : @return an HTML5 home page
 :)
declare %public function m:home(
)
{
  html5:html()
};
