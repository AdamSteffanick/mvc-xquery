xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery model function library module.
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
module namespace m = "model";

(:~
 : A function to return a minimal HTML5 meta element and optional meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more meta elements
 : @return a sequence of one or more meta elements
 :)
declare %private function m:html5-head-meta(
  $parameter as element(meta)*
) as element(meta)+
{
  let $meta-parameter := (
    element meta {
      attribute charset {
        "utf-8"
      }
    },
    $parameter
  )
  return (
    $meta-parameter
  )
};

(:~
 : A function to return an optional base element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one base elements
 : @return a sequence of zero or one base elements
 :)
declare %private function m:html5-base(
  $parameter as element(base)?
) as element(base)?
{
  $parameter
};

(:~
 : A function to return a title element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one strings
 : @return one title element (default: MVC-XQuery…)
 :)
declare %private function m:html5-title(
  $parameter as xs:string?
) as element(title)
{
  let $title-parameter := (
    element title {
      if (
        fn:string-length($parameter) > 0
      )
      then (
        $parameter
      )
      else (
        "MVC-XQuery | A Model-View-Controller framework for BaseX"
      )
    }
  )
  return (
    $title-parameter
  )
};

(:~
 : A function to return optional link elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more link elements
 : @return a sequence of zero or more link elements
 :)
declare %private function m:html5-link(
  $parameter as element(link)*
) as element(link)*
{
  $parameter
};

(:~
 : A function to return optional style elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more style elements
 : @return a sequence of zero or more style elements
 :)
declare %private function m:html5-style(
  $parameter as element(style)*
) as element(style)*
{
  $parameter
};

(:~
 : A function to return optional script elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more script elements
 : @return a sequence of zero or more script elements
 :)
declare %private function m:html5-script(
  $parameter as element(script)*
) as element(script)*
{
  $parameter
};

(:~
 : A function to return an optional noscript element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one noscript elements
 : @return a sequence of zero or one noscript elements
 :)
declare %private function m:html5-noscript(
  $parameter as element(noscript)?
) as element(noscript)?
{
  $parameter
};

(:~
 : A function to return optional meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more meta elements
 : @return a sequence of zero or more meta elements
 :)
declare %private function m:html5-meta(
  $parameter as element(meta)*
) as element(meta)*
{
  $parameter
};

(:~
 : A function to return an optional template element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one template elements
 : @return a sequence of zero or one template elements
 :)
declare %private function m:html5-template(
  $parameter as element(template)?
) as element(template)?
{
  $parameter
};

(:~
 : A function to return a lang attribute.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one strings
 : @return one lang attribute (default: en)
 :)
declare %private function m:html5-lang(
  $parameter as xs:string?
) as attribute(lang)
{
  let $lang-parameter := (
    attribute lang {
      if (
        fn:string-length($parameter) > 0
      )
      then (
        $parameter
      )
      else (
        "en"
      )
    }
  )
  return (
    $lang-parameter
  )
};

(:~
 : A function to filter HTML5 elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return a sequence of zero or more items (default: <h1>Hello, world!</h1>)
 : @error mvc-xquery: item() must be of type element() or xs:string
 :)
declare %private function m:html5-filter(
  $parameter as item()*
) as item()*
{
  if (
    fn:empty($parameter)
  )
  then (
    element h1 {
      "Hello, world!"
    }
  )
  else (
    for $item in $parameter
    return (
      if (
        $item instance of element()
        or $item instance of xs:string
      )
      then (
        $item
      )
      else (
        element pre {
          element i {
            "mvc-xquery"
          },
          ": item() must be of type element() or xs:string"
        }
      )
    )
  )
};

(:~
 : A function to return a minimal HTML5 head element and optional elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param (optional) $options is a sequence of zero or one map items
 : @return one minimal HTML5 head element containing optional elements
 :)
declare function m:html5-head(
) as element(head)
{
  let $head := (
    element head {
      m:html5-head-meta(()),
      m:html5-title(())
    }
  )
  return (
    $head
  )
};
declare function m:html5-head(
  $options as map(*)?
) as element(head)
{
  let $head := (
    element head {
      m:html5-head-meta(map:get($options, "meta")),
      m:html5-base(map:get($options, "base")),
      m:html5-title(map:get($options, "title")),
      m:html5-link(map:get($options, "link")),
      m:html5-style(map:get($options, "style")),
      m:html5-script(map:get($options, "script")),
      m:html5-noscript(map:get($options, "noscript")),
      m:html5-meta(map:get($options, "metadata")),
      m:html5-template(map:get($options, "template"))
    }
  )
  return (
    $head
  )
};

(:~
 : A function to return a minimal HTML5 body element and optional items.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of zero or more items
 : @param (optional) $options is a sequence of zero or one map items
 : @return one minimal HTML5 body element containing optional items
 :)
declare function m:html5-body(
) as element(body)
{
  element body {
    m:html5-filter(())
  }
};
declare function m:html5-body(
  $parameter as item()*
) as element(body)
{
  let $content := (
     m:html5-filter($parameter)
  )
  return (
    element body {
      $content
    }
  )
};
declare function m:html5-body(
  $parameter as item()*,
  $options as map(*)?
) as element(body)
{
  let $content := (
     m:html5-filter($parameter)
  )
  return (
    element body {
      $content,
      m:html5-script(map:get($options, "script"))
    }
  )
};

(:~
 : A function to return a minimal HTML5 html element and optional items.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.1.0
 :
 : @param (optional) $head is one head element
 : @param (optional) $body is one body element
 : @param (optional) $options is a sequence of zero or one map items
 : @return one minimal HTML5 html element containing optional items
 :)
declare function m:html5(
) as element(html)
{
  element html {
    m:html5-lang(()),
    m:html5-head(),
    m:html5-body()
  }
};
declare function m:html5(
  $head as element(head)
) as element(html)
{
  element html {
    m:html5-lang(()),
    $head,
    m:html5-body()
  }
};
declare function m:html5(
  $head as element(head),
  $body as element(body)
) as element(html)
{
  element html {
    m:html5-lang(()),
    $head,
    $body
  }
};
declare function m:html5(
  $head as element(head),
  $body as element(body),
  $options as map(*)?
) as element(html)
{
  let $html := (
    element html {
      m:html5-lang(map:get($options, "lang")),
      $head,
      $body
    }
  )
  return (
    $html
  )
};