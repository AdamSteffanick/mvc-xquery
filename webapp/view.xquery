xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery view function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework for BaseX
 : Copyright (C) 2018 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.1.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : April 6, 2018
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

(:~
 : A function to return HTML to the user.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $html is one html element
 : @return one html element
 :)
declare function v:html(
  $html as element(html)
) as element(html)
{
  $html
};