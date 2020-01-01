xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery TEI function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX
 : Copyright (C) 2018–2020 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.5.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : January 1, 2020
 : @since v0.5.0
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
module namespace mvc-tei = "mvc-tei";

(: required function library modules :)
import module namespace mvc = "mvc" at "mvc.xquery";

(: required namespace declaration :)
declare namespace tei = "http://www.tei-c.org/ns/1.0";

(:~
 : A public function to convert TEI to HTML.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $nodes is a sequence of zero or more TEI nodes
 : @return one HTML node
 :)
declare function mvc-tei:dispatch($nodes as node()*) {
  for $node in $nodes
  return
  mvc:minify(
    typeswitch($node)
    case text() return $node (: mvc-tei:mvc-tei-text($node) :)
    case comment() return $node
    case element(tei:w) return mvc-tei:w($node)
    case element(tei:s) return mvc-tei:s($node)
    case element(tei:seg) return mvc-tei:seg($node)
    case element(tei:p) return mvc-tei:p($node)
    case element(tei:bibl) return mvc-tei:bibl($node)
    case element(tei:ref) return mvc-tei:ref($node)
    case element(tei:quote) return mvc-tei:quote($node)
    case element(tei:q) return mvc-tei:q($node)
    case element(tei:hi) return mvc-tei:hi($node)
    case element(tei:mark) return mvc-tei:mark($node)
    case element(tei:pb) return mvc-tei:pb($node)
    case element(tei:lb) return mvc-tei:lb($node)
    case element(tei:body) return mvc-tei:body($node)
    default return mvc-tei:passthru($node)
  )
};

(:~
 : A private function to recurse through child nodes for mvc-tei:dispatch().
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is a sequence of zero or more TEI nodes
 : @return one HTML node
 :)
declare %private function mvc-tei:passthru($node as node()*) as item()* {
  element {name($node)} {($node/@*, mvc-tei:dispatch($node/node()))}
};

(:~
 : A private function to convert <w> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:w element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:w($node as element(tei:w)) as element() {
  let $lemmaRef := $node/@lemmaRef
  return
  <span class="word" data-mvc-tei-lemmaRef="{$lemmaRef}">{mvc-tei:dispatch($node/node())}</span>
};

(:~
 : A private function to convert <s> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:s element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:s($node as element(tei:s)) as element() {
  let $sentence := $node/@n
  return
  <span class="sentence" data-mvc-tei-s="{$sentence}">{mvc-tei:dispatch($node/node())}</span>
};

(:~
 : A private function to convert <seg> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:seg element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:seg($node as element(tei:seg)) as element() {
  let $type := $node/@type
  return
  <span data-mvc-tei-seg="{$type}">{mvc-tei:dispatch($node/node())}</span>
};

(:~
 : A private function to convert <p> to <p> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:p element
 : @return one p element with attributes
 :)
declare %private function mvc-tei:p($node as element(tei:p)) as element() {
  <p>{mvc-tei:dispatch($node/node())}</p>
};

(:~
 : A private function to convert <bibl> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:bibl element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:bibl($node as element(tei:bibl)) as element() {
  <span class="citation">{mvc-tei:dispatch($node/node())}</span>
};

(:~
 : A private function to convert <ref> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:ref element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:ref($node as element(tei:ref)) as element() {
  <span class="reference">{mvc-tei:dispatch($node/node())}</span>
};

(:~
 : A private function to convert <quote> to <blockquote> or <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:quote element
 : @return one blockquote or span element with attributes
 :)
declare %private function mvc-tei:quote($node as element(tei:quote)) as element() {
  let $rend := $node/@rend
  return
  if ($rend = 'blockquote') then
    <blockquote>{mvc-tei:dispatch($node/node())}</blockquote>
  else
    <span class="quotation">“{mvc-tei:dispatch($node/node())}”</span>
};

(:~
 : A private function to convert <q> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:q element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:q($node as element(tei:q)) as element() {
  <span class="quotes">“{mvc-tei:dispatch($node/node())}”</span>
};

(:~
 : A private function to convert <hi> to <i> or <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:hi element
 : @return one i or span element with attributes
 :)
declare %private function mvc-tei:hi($node as element(tei:hi)) as element() {
  let $rend := $node/@rend
  return
  if ($rend = 'italic') then
    <i>{mvc-tei:dispatch($node/node())}</i>
  else
    <span>{mvc-tei:dispatch($node/node())}</span>
};

(:~
 : A private function to convert <mark> to <mark> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:mark element
 : @return one mark element with attributes
 :)
declare %private function mvc-tei:mark($node as element(tei:mark)) as element() {
  <mark>{mvc-tei:dispatch($node/node())}</mark>
};

(:~
 : A private function to convert <pb> to <span> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:pb element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:pb($node as element(tei:pb)) {
  <span data-mvc-tei-pb=""></span>
};

(:~
 : A private function to convert <lb> to <br>.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:lb element
 : @return one span br with attributes
 :)
declare %private function mvc-tei:lb($node as element(tei:lb)) as element() {
  <br />
};

(:~
 : A private function to convert <body> to <article> with attributes.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.5.0
 :
 : @param $node is one tei:body element
 : @return one span element with attributes
 :)
declare %private function mvc-tei:body($node as element(tei:body)) as element() {
  <article data-mvc-tei-body="">{mvc-tei:dispatch($node/node())}</article>
};
