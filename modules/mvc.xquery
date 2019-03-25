xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX
 : Copyright (C) 2018–2019 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.4.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : March 25, 2019
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
import module namespace bootstrap = "bootstrap" at "bootstrap.xquery";
import module namespace html5 = "html5" at "html5.xquery";

(:~
 : A public variable containing the MVC-XQuery version.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.4.0
 :
 : @return one string containing the MVC-XQuery brand
 :)
declare %public variable $mvc:version as xs:string := (
  "v0.4.0"
);

(:~
 : A public variable containing the MVC-XQuery brand.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
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
 : @version v1.0.0
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
 : @version v1.0.0
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
 : @version v1.0.0
 : @since v0.4.0
 :
 : @return one CSV formatted string: path,title
 :)
declare %public variable $mvc:paths as xs:string := (
  (
    "/,Home"
  )
  => fn:string-join(out:nl())
);

(:~
 : A public variable containing the MVC-XQuery template.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.4.0
 :
 : @return one MVC-XQuery template map item
 :)
declare %public variable $mvc:template as map(*) := (
  map {
    "head" : map {
      "title" : $mvc:title
    },
    "body" : map {
      "content" : ""
    }
  }
);

(:~
 : A public function to return MVC-XQuery path elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
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
 : A public function to refine the parameter of html5:html() for MVC-XQuery.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v3.0.0
 : @since v0.2.2
 :
 : @param $parameter is a sequence of one or more map items
 : @return one map item for use with html5:html()
 :)
declare %public function mvc:html-refine(
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
