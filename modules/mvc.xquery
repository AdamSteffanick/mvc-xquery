xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX
 : Copyright (C) 2018–2026 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : April 8, 2026
 : @since v0.4.0
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
module namespace mvc = "mvc";

(: required function library modules :)
import module namespace mvc-tei = "mvc-tei" at "tei.xquery";

(:~
 : A public variable containing the MVC-XQuery version.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.4.0
 :
 : @return one string containing the MVC-XQuery brand
 :)
declare %public variable $mvc:version as xs:string := (
  "v0.6.0"
);

(:~
 : A public variable containing the MVC-XQuery brand.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.4.0
 : @since v0.4.0
 :
 : @return one string containing the MVC-XQuery brand
 :)
declare %public variable $mvc:brand as xs:string := (
  "MVC-XQuery"
);

(:~
 : A public variable containing the MVC-XQuery brand description.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.4.0
 : @since v0.4.0
 :
 : @return one string containing the MVC-XQuery brand description
 :)
declare %public variable $mvc:brand-description as xs:string := (
  "A Model-View-Controller framework in XQuery for BaseX"
);

(:~
 : A public variable containing the MVC-XQuery default title.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.4.0
 : @since v0.4.0
 :
 : @return one string containing the MVC-XQuery default title
 :)
declare %public variable $mvc:title as xs:string := (
  (
    $mvc:brand,
    "|",
    $mvc:brand-description
  )
  => fn:string-join(" ")
);

(:~
 : A public variable containing CSV formatted paths for MVC-XQuery.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.4.0
 :
 : @return one CSV formatted string: path,title
 :)
declare %public variable $mvc:paths as xs:string := (
  (
    "/,Home"
  )
  => fn:string-join(fn:char('\n'))
);

(:~
 : A public function to return MVC-XQuery path elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.4.0
 : @since v0.4.0
 :
 : @param $parameter is one CSV formatted string: path,title
 : @return a sequence of one or more MVC-XQuery path elements
 :)
declare %public function mvc:list-paths(
  $parameter as xs:string
) as element(path)+
{
  let $records := (
    $parameter
    => csv:parse()
  )
  let $segmented-paths := (
    for $path in $records/csv/record/entry[1]
    return (
      $path
      => fn:analyze-string("/")
    )
  )
  let $path-length-map := map:merge(
    for $path-head in fn:distinct-values($segmented-paths/fn:non-match[1])
    let $path-lengths := (
      for $segmented-path in $segmented-paths
      where (
        $segmented-path/fn:non-match[1] = $path-head
      )
      return (
        $segmented-path/fn:non-match
        => fn:count()
      )
    )
    return (
      map {
        $path-head : fn:max($path-lengths)
      }
    )
  )
  let $get-path-title := (
    function (
      $path as xs:string
    ) as xs:string
    {
      for $record in $records/csv/record
      where (
        $record/entry[1] = $path
      )
      return (
        $record/entry[2]
      )
    }
  )
  let $path-elements := (
    <path segments="0" parent="/" title="{$get-path-title("/")}">/</path>,
    for $path-head in map:keys($path-length-map)
    return (
      for $segment-position in (1 to map:get($path-length-map, $path-head))
      return (
        for $segmented-path in $segmented-paths
        where (
          $segmented-path/fn:non-match[1] = $path-head
          and fn:count($segmented-path/fn:non-match) = $segment-position
        )
        let $parent := (
          if (
            $segment-position = 1
          )
          then (
            "/"
          )
          else (
            $segmented-path
            => fn:string()
            => fn:replace($segmented-path/fn:non-match[$segment-position], "")
            => fn:replace("//", "/")
          )
        )
        return (
          element path {
            attribute segments {
              $segment-position
            },
            attribute parent {
              $parent
            },
            attribute title {
              $segmented-path
              => fn:string()
              => $get-path-title()
            },
            $segmented-path
            => fn:string()
          }
        )
      )
    )
  )
  return (
    $path-elements
  )
};


(:~
 : A public function to refine the parameter of mvc:html() for MVC-XQuery.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.2.2
 :
 : @param $parameter is a sequence of one or more map items
 : @return one map item for use with mvc:html()
 :)
declare %public function mvc:refine-html(
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
 : A public function to minify the HTML output of ft:mark() for BaseX.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.5.0
 :
 : @param $parameter is a sequence of zero or more nodes
 : @return one minified node
 :)
declare %public function mvc:minify-html-mark($parameter as node()*) {
  let $serialization-parameters :=
    <serialization-parameters xmlns="http://www.w3.org/2010/xslt-xquery-serialization">
      <omit-xml-declaration value="yes"/>
    </serialization-parameters>
  let $codeString := fn:serialize($parameter, $serialization-parameters)

(:  let $codeStringNormalized := fn:replace($codeString, "\s+", " ") :)
  let $codeStringMinifyElementWhitespace := fn:replace($codeString, "&#10;\s+", "&#10;")
(:  let $codeStringMinifyElementWhitespace2 := fn:replace($codeString, ">\s+<", "><") :)
  let $codeStringMinifyCloseSpans := fn:replace($codeStringMinifyElementWhitespace, "</span>\s+</span>", "</span></span>")
  let $codeStringMinifyCloseMarkLF := fn:replace($codeStringMinifyCloseSpans, "</mark>&#10;", "</mark>")
  let $codeStringMinifyLFCloseI := fn:replace($codeStringMinifyCloseMarkLF, "&#10;</i>", "</i>")
  let $codeStringMinifyQuoteLF := fn:replace($codeStringMinifyLFCloseI, "“&#10;", "“")
  let $codeStringMinifyLFQuote := fn:replace($codeStringMinifyQuoteLF, "&#10;”", "”")

  return fn:parse-xml-fragment($codeStringMinifyLFQuote)
};

(:~
 : A private function to filter HTML elements for MVC-XQuery.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return a sequence of zero or more items (default: <h1>Hello, world!</h1>)
 : @error mvc: item() must be of type element() or xs:string
 :)
declare %private function mvc:filter-html(
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
            "mvc"
          },
          ": item() must be of type element() or xs:string"
        }
      )
    )
  )
};

(:~
 : A private function to return priority HTML meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more meta elements
 : @return a sequence of one or more meta elements
 :)
declare %private function mvc:html-meta-priority(
  $parameter as element(meta)*
) as element(meta)+
{
  let $meta-parameter := (
    element meta {
      attribute charset {
        "utf-8"
      }
    },
    element meta {
      attribute name {
        "viewport"
      },
      attribute content {
        "width=device-width, initial-scale=1.0"
      }
    },
    $parameter
  )
  return (
    $meta-parameter
  )
};

(:~
 : A private function to return an optional HTML base element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one base elements
 : @return a sequence of zero or one base elements
 :)
declare %private function mvc:html-base(
  $parameter as element(base)?
) as element(base)?
{
  $parameter
};

(:~
 : A private function to return an HTML title element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one strings
 : @return one title element (default: MVC-XQuery…)
 :)
declare %private function mvc:html-title(
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
        $mvc:title
      )
    }
  )
  return (
    $title-parameter
  )
};

(:~
 : A private function to return optional HTML link elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more link elements
 : @return a sequence of zero or more link elements
 :)
declare %private function mvc:html-link(
  $parameter as element(link)*
) as element(link)*
{
  $parameter
};

(:~
 : A private function to return optional HTML style elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more style elements
 : @return a sequence of zero or more style elements
 :)
declare %private function mvc:html-style(
  $parameter as element(style)*
) as element(style)*
{
  $parameter
};

(:~
 : A private function to return optional HTML script elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more script elements
 : @return a sequence of zero or more script elements
 :)
declare %private function mvc:html-script(
  $parameter as element(script)*
) as element(script)*
{
  $parameter
};

(:~
 : A private function to return an optional HTML noscript element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one noscript elements
 : @return a sequence of zero or one noscript elements
 :)
declare %private function mvc:html-noscript(
  $parameter as element(noscript)?
) as element(noscript)?
{
  $parameter
};

(:~
 : A private function to return optional HTML meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or more meta elements
 : @return a sequence of zero or more meta elements
 :)
declare %private function mvc:html-meta(
  $parameter as element(meta)*
) as element(meta)*
{
  $parameter
};

(:~
 : A private function to return an optional HTML template element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one template elements
 : @return a sequence of zero or one template elements
 :)
declare %private function mvc:html-template(
  $parameter as element(template)?
) as element(template)?
{
  $parameter
};

(:~
 : A private function to return an HTML lang attribute.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param $parameter is a sequence of zero or one strings
 : @return one lang attribute (default: en)
 :)
declare %private function mvc:html-lang(
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
 : A private function to return an HTML head element and optional elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of zero or one map items
 : @return one minimal HTML head element containing optional elements
 :)
declare %private function mvc:html-head(
) as element(head)
{
  let $head := (
    element head {
      mvc:html-meta-priority(()),
      mvc:html-title(())
    }
  )
  return (
    $head
  )
};
declare %private function mvc:html-head(
  $parameter as map(*)?
) as element(head)
{
  let $head := (
    if (
      $parameter => fn:empty()
    )
    then (
      mvc:html-head()
    )
    else (
      element head {
        mvc:html-meta-priority(map:get($parameter, "meta-priority")),
        mvc:html-base(map:get($parameter, "base")),
        mvc:html-title(map:get($parameter, "title")),
        mvc:html-link(map:get($parameter, "link")),
        mvc:html-style(map:get($parameter, "style")),
        mvc:html-script(map:get($parameter, "script")),
        mvc:html-noscript(map:get($parameter, "noscript")),
        mvc:html-meta(map:get($parameter, "meta")),
        mvc:html-template(map:get($parameter, "template"))
      }
    )
  )
  return (
    $head
  )
};

(:~
 : A public function to return an HTML element.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.3.0
 :
 : @param $parameter is one map item
 : @return one HTML element containing optional items
 : @error mvc: item() must be of type element() or xs:string
 :)
declare %public function mvc:html-element(
  $parameter as map(*)
) as element()
{
  if (
    map:get($parameter, "name") => fn:empty()
  )
  then (
    element pre {
      element i {
        "mvc"
      },
      ": mvc:html-element($parameter) must contain the key “name”"
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
 : A private function to return an HTML body element and optional items.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of zero or one map items
 : @return one minimal HTML body element containing optional items
 :)
declare %private function mvc:html-body(
) as element(body)
{
  element body {
    mvc:filter-html(())
  }
};
declare %private function mvc:html-body(
  $parameter as map(*)?
) as element(body)
{
  if (
    $parameter => fn:empty()
  )
  then (
    mvc:html-body()
  )
  else (
    element body {
      mvc:filter-html(map:get($parameter, "content")),
      mvc:html-script(map:get($parameter, "script"))
    }
  )
};

(:~
 : A public function to return an HTML html element and optional items.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.6.0
 : @since v0.1.0
 :
 : @param (optional) $parameter is a sequence of one or more map items
 : @return one minimal HTML html element containing optional items
 :)
declare %public function mvc:html(
) as element(html)
{
  element html {
    mvc:html-lang(()),
    mvc:html-head(),
    mvc:html-body()
  }
};
declare %public function mvc:html(
  $parameter as map(*)+
) as element(html)
{
  let $refined-input := (
    mvc:refine-html($parameter)
  )
  let $html := (
    element html {
      mvc:html-lang(map:get($refined-input, "lang")),
      mvc:html-head(map:get($refined-input, "head")),
      mvc:html-body(map:get($refined-input, "body"))
    }
  )
  return (
    $html
  )
};