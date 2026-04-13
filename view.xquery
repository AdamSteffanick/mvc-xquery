xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery view function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX
 : Copyright (C) 2018–2026 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : April 8, 2026
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
module namespace v = "view";

(: required function library modules :)
import module namespace mvc = "mvc" at "modules/mvc.xquery";

(: optional function library modules :)

(:~
 : A public function to return HTML to the user.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $html is one html element
 : @return one html element
 :)
declare %public function v:html(
  $data as map(*)+
) as element(html)
{
  $data
  => mvc:html()
};