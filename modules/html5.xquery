xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery HTML v5.2 function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework for BaseX
 : Copyright (C) 2018–2019 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.3.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : February 26, 2019
 : @since v0.3.0
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
module namespace html5 = "html5";

(:~
 : A function to filter HTML5 elements for MVC-XQuery.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return a sequence of zero or more items (default: <h1>Hello, world!</h1>)
 : @error mvc-xquery: item() must be of type element() or xs:string
 :)
declare %private function html5:html-filter(
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
 : A function to refine the parameter of html5:html() for MVC-XQuery.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.0.0
 : @since v0.2.2
 :
 : @param $parameter is a sequence of one or more map items
 : @return one map item for use with html5:html()
 :)
declare %private function html5:html-refine(
  $parameter as map(*)+
) as map(*)
{
  let $refined-input := (
    let $unrefined-input := (
      $parameter
      => map:merge(map {"duplicates" : "combine"})
    )
    let $merged-input := (
      let $simplex-maps := (
        for $key in map:keys($unrefined-input)
        where (
          $key = "lang"
        )
        return (
          map {
            $key : (
              map:get($unrefined-input, $key)
            )
          }
        )
      )
      let $complex-maps := (
        for $key in map:keys($unrefined-input)
        where (
          $key = "head"
          or $key = "body"
        )
        return (
          map {
            $key : (
              if (
                fn:count(map:get($unrefined-input, $key)) > 1
              )
              then (
                let $values := (
                  map:get($unrefined-input, $key)
                  => map:merge(map {"duplicates" : "combine"})
                )
                return (
                  $values
                )
              )
              else (
                map:get($unrefined-input, $key)
              )
            )
          }
        )
      )
      return (
        $simplex-maps,
        $complex-maps
      )
    ) => map:merge()
    let $clean-input := (
      for $key in map:keys($merged-input)
      return (
        map {
          $key : (
            if (
              $key = "lang"
            )
            then (
              $merged-input
              => map:get($key)
              => fn:reverse()
              => fn:head()
            )
            else if (
              $key = "head"
            )
            then (
              map:merge(
                for $child-map in map:get($merged-input, $key)
                return (
                  for $child-key in map:keys($child-map)
                  return (
                    map {
                      $child-key : (
                        if (
                          $child-key = "base"
                          or $child-key = "title"
                          or $child-key = "no-script"
                          or $child-key = "template"
                        )
                        then (
                          map:get($child-map, $child-key)
                          => fn:reverse()
                          => fn:head()
                        )
                        else (
                          map:get($child-map, $child-key)
                        )
                      )
                    }
                  )
                )
              )
            )
            else if (
              $key = "body"
            )
            then(
              for $child-map in map:get($merged-input, $key)
              return (
                $child-map
              )
            )
          )
        }
      )
    )
    return (
      $clean-input
      => map:merge()
    )
  )
  return (
    $refined-input
  )
};

(:~
 : A function to return a minimal HTML5 meta element and optional meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more meta elements
 : @return a sequence of one or more meta elements
 :)
declare %private function html5:meta-priority(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one base elements
 : @return a sequence of zero or one base elements
 :)
declare %private function html5:base(
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
 : @version v1.0.1
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one strings
 : @return one title element (default: MVC-XQuery…)
 :)
declare %private function html5:title(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more link elements
 : @return a sequence of zero or more link elements
 :)
declare %private function html5:link(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more style elements
 : @return a sequence of zero or more style elements
 :)
declare %private function html5:style(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more script elements
 : @return a sequence of zero or more script elements
 :)
declare %private function html5:script(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one noscript elements
 : @return a sequence of zero or one noscript elements
 :)
declare %private function html5:noscript(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more meta elements
 : @return a sequence of zero or more meta elements
 :)
declare %private function html5:meta(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one template elements
 : @return a sequence of zero or one template elements
 :)
declare %private function html5:template(
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
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one strings
 : @return one lang attribute (default: en)
 :)
declare %private function html5:lang(
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
 : A function to return a minimal HTML5 head element and optional elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.0.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of zero or one map items
 : @return one minimal HTML5 head element containing optional elements
 :)
declare %private function html5:head(
) as element(head)
{
  let $head := (
    element head {
      html5:meta-priority(()),
      html5:title(())
    }
  )
  return (
    $head
  )
};
declare %private function html5:head(
  $parameter as map(*)?
) as element(head)
{
  let $head := (
    if (
      $parameter => fn:empty()
    )
    then (
      html5:head()
    )
    else (
      element head {
        html5:meta-priority(map:get($parameter, "meta-priority")),
        html5:base(map:get($parameter, "base")),
        html5:title(map:get($parameter, "title")),
        html5:link(map:get($parameter, "link")),
        html5:style(map:get($parameter, "style")),
        html5:script(map:get($parameter, "script")),
        html5:noscript(map:get($parameter, "noscript")),
        html5:meta(map:get($parameter, "meta")),
        html5:template(map:get($parameter, "template"))
      }
    )
  )
  return (
    $head
  )
};

(:~
 : A public function to return an HTML5 element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.3.0
 :
 : @param $parameter is one map item
 : @return one HTML5 element containing optional items
 : @error mvc-xquery: item() must be of type element() or xs:string
 :)
declare %public function html5:element(
  $parameter as map(*)
) as element()
{
  if (
    map:get($parameter, "name") => fn:empty()
  )
  then (
    element pre {
      element i {
        "mvc-xquery"
      },
      ": html5:element($parameter) must contain the key “name”"
    }
  )
  else (
    let $name := (
      map:get($parameter, "name")
      => fn:lower-case()
    )
    let $attributes := (
      if (
        map:get($parameter, "attributes") => fn:empty()
      )
      then (
      )
      else (
        for $attribute in map:keys(map:get($parameter, "attributes"))
        let $value := (
          map:get(
            map:get($parameter, "attributes"),
            $attribute
          )
        )
        return (
          attribute {$attribute} {$value}
        )
      )
    )
    let $content := (
      map:get($parameter, "content")
    )
    return (
      element {$name} {$attributes, $content}
    )
  )
};

(:~
 : A function to return a minimal HTML5 body element and optional items.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v3.0.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of zero or one map items
 : @return one minimal HTML5 body element containing optional items
 :)
declare %private function html5:body(
) as element(body)
{
  element body {
    html5:html-filter(())
  }
};
declare %private function html5:body(
  $parameter as map(*)?
) as element(body)
{
  if (
    $parameter => fn:empty()
  )
  then (
    html5:body()
  )
  else (
    element body {
      html5:html-filter(map:get($parameter, "content")),
      html5:script(map:get($parameter, "script"))
    }
  )
};

(:~
 : A function to return a minimal HTML5 html element and optional items.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v3.0.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of one or more map items
 : @return one minimal HTML5 html element containing optional items
 :)
declare %public function html5:html(
) as element(html)
{
  element html {
    html5:lang(()),
    html5:head(),
    html5:body()
  }
};
declare %public function html5:html(
  $parameter as map(*)+
) as element(html)
{
  let $refined-input := (
    html5:html-refine($parameter)
  )
  let $html := (
    element html {
      html5:lang(map:get($refined-input, "lang")),
      html5:head(map:get($refined-input, "head")),
      html5:body(map:get($refined-input, "body"))
    }
  )
  return (
    $html
  )
};
