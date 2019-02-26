xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery Bootstrap v4.2.1 function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework for BaseX
 : Copyright (C) 2018–2019 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.3.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : February 26, 2019
 : @since v0.2.0
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
module namespace bootstrap = "bootstrap";

(:~
 : A public variable containing minimal Bootstrap template requirements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.2.2
 :
 : @return one map containing minimal Bootstrap template requirements
 :)
declare %public variable $bootstrap:template as map(*) := map
{
  "head" : map {
    "meta" : bootstrap:meta(),
    "link" : bootstrap:stylesheet()
  },
  "body" : map {
    "script" : bootstrap:javascript()
  }
};

(:~
 : A function to return required Bootstrap meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @return a sequence of required Bootstrap meta elements
 :)
declare %public function bootstrap:meta(
) as element(meta)
{
  element meta {
    attribute name {
      "viewport"
    },
    attribute content {
      "width=device-width, initial-scale=1, shrink-to-fit=no"
    }
  }
};

(:~
 : A function to return Bootstrap CSS.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
 : @since v0.2.0
 :
 : @return one Bootstrap link element referencing an external stylesheet
 :)
declare %public function bootstrap:stylesheet(
) as element(link)
{
  element link {
    attribute rel {
      "stylesheet"
    },
    attribute href {
      "https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
    },
    attribute integrity {
      "sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
    },
    attribute crossorigin {
      "anonymous"
    }
  }
};

(:~
 : A function to return Bootstrap optional JavaScript.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
 : @since v0.2.0
 :
 : @return a sequence of Bootstrap script elements referncing external JavaScript
 :)
declare %public function bootstrap:javascript(
) as element(script)*
{
  element script {
    attribute src {
      "https://code.jquery.com/jquery-3.3.1.slim.min.js"
    },
    attribute integrity {
      "sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    },
    attribute crossorigin {
      "anonymous"
    }
  },
  element script {
    attribute src {
      "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
    },
    attribute integrity {
      "sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
    },
    attribute crossorigin {
      "anonymous"
    }
  },
  element script {
    attribute src {
      "https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
    },
    attribute integrity {
      "sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
    },
    attribute crossorigin {
      "anonymous"
    }
  }
};

(:~
 : A function to return a Bootstrap navbar component brand.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $parameter is a string
 : @return one Bootstrap navbar brand as a heading
 :)
declare %public function bootstrap:navbar-brand(
  $parameter as xs:string
) as element(span)
{
  element span {
    attribute class {
      "navbar-brand mb-0 h1"
    },
    $parameter
  }
};

(:~
 : A function to return a Bootstrap navbar component list.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $parameter is a CSV string with header values: parent,loc,name
 : @return one Bootstrap navbar ul element
 :)
declare %public function bootstrap:navbar-ul(
  $parameter as xs:string
) as element(ul)
{
  let $csv := (
    csv:parse($parameter, map {"header": true()})
  )
  let $dropdowns := (
    for $dropdown in $csv/csv/record
    where (
      $dropdown/parent/text() != "/"
      and (
        $dropdown/parent/text()
        => fn:empty()
        => fn:not()
      )
    )
    return (
      $dropdown/parent/text()
      => fn:distinct-values()
    )
  )
  return (
    element ul {
      attribute class {
        "navbar-nav mr-auto mt-2 mt-lg-0"
      },
      for $item in $csv/csv/record
      where (
        $item/parent/text()
        => fn:empty()
        or  (
          $item/parent/text() = "/"
        )
      )
      return (
        if (
          $dropdowns
          => fn:index-of($item/loc/text())
          => fn:exists()
          => fn:not()
        )
        then (
          element li {
            attribute class {
              "nav-item"
            },
            element a {
              attribute class {
                "nav-link"
              },
              attribute href {
                $item/parent/text()
                || $item/loc/text()
              },
              $item/name/text()
            }
          }
        )
        else (
          element li {
            attribute class {
              "nav-item dropdown"
            },
            element a {
              attribute class {
                "nav-link dropdown-toggle"
              },
              attribute href {
                "#"
              },
              attribute id {
                (
                  "navbar-"
                  || $item/loc/text()
                )
                => fn:replace("/", "")
              },
              attribute role {
                "button"
              },
              attribute data-toggle {
                "dropdown"
              },
              attribute aria-haspopup {
                "true"
              },
              attribute aria-expanded {
                "false"
              },
              $item/name/text()
            },
            element div {
              attribute class {
                "dropdown-menu"
              },
              attribute aria-labelledby {
                (
                  "navbar-"
                  || $item/loc/text()
                )
                => fn:replace("/", "")
              },
              element a {
                attribute class {
                  "dropdown-item"
                },
                attribute href {
                  $item/parent/text()
                  || $item/loc/text()
                },
                $item/name/text()
              },
              for $child in $csv/csv/record
              where (
                $child/parent/text() = $item/loc/text()
              )
              return (
                element a {
                  attribute class {
                    "dropdown-item"
                  },
                  attribute href {
                    $item/parent/text()
                    || $child/parent/text()
                    || $child/loc/text()
                  },
                  $child/name/text()
                }
              )
            }
          }
        )
      )
    }
  )
};

(:~
 : A function to return a Bootstrap navbar component search form.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.0.0
 : @since v0.2.0
 :
 : @param (optional) $parameter is a sequence of zero or one map items
 : @return one Bootstrap navbar search form
 :)
declare %public function bootstrap:navbar-search(
) as element(form)
{
  element form {
    attribute class {
      "form-inline my-2 my-lg-0"
    },
    element input {
      attribute class {
        "form-control mr-sm-2"
      },
      attribute type {
        "search"
      },
      attribute name {
        "q"
      },
      attribute placeholder {
        "Search"
      },
      attribute required {
        "required"
      },
      attribute aria-label {
        "Search"
      }
    },
    element button {
      attribute class {
        "btn btn-outline-light my-2 my-sm-0"
      },
      attribute type {
        "submit"
      },
      attribute formaction {
        "/search/"
      },
      "Search"
    }
  }
};
declare %public function bootstrap:navbar-search(
  $parameter as map(*)?
) as element(form)
{
  let $name := (
    if (
      map:get($parameter, "name")
      => fn:empty()
    )
    then (
      "q"
    )
    else (
      map:get($parameter, "name")
    )
  )
  let $formaction := (
    if (
      map:get($parameter, "formaction")
      => fn:empty()
    )
    then (
      "/search/"
    )
    else (
      map:get($parameter, "formaction")
    )
  )
  return (
    element form {
      attribute class {
        "form-inline my-2 my-lg-0"
      },
      element input {
        attribute class {
          "form-control mr-sm-2"
        },
        attribute type {
          "search"
        },
        attribute name {
          $name
        },
        attribute placeholder {
          "Search"
        },
        attribute required {
          "required"
        },
        attribute aria-label {
          "Search"
        }
      },
      element button {
        attribute class {
          "btn btn-outline-light my-2 my-sm-0"
        },
        attribute type {
          "submit"
        },
        attribute formaction {
          $formaction
        },
        "Search"
      }
    }
  )
};

(:~
 : A function to return a Bootstrap navbar component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $parameter is one Bootstrap navbar ul element
 : @return one Bootstrap navbar
 :)
declare %public function bootstrap:navbar(
  $parameter as item()*
) as element(nav)
{
  element nav {
    attribute class {
      "navbar navbar-expand-lg navbar-dark bg-dark"
    },
    element button {
      attribute class {
        "navbar-toggler"
      },
      attribute type {
        "button"
      },
      attribute data-toggle {
        "collapse"
      },
      attribute data-target {
        "#navbarNav"
      },
      attribute aria-controls {
        "navbarNav"
      },
      attribute aria-expanded {
        "false"
      },
      attribute aria-label {
        "Toggle navigation"
      },
      element span {
        attribute class {
          "navbar-toggler-icon"
        }
      }
    },
    element div {
      attribute class {
        "collapse navbar-collapse"
      },
      attribute id {
        "navbarNav"
      },
      $parameter
    }
  }
};

(:~
 : A function to return a Bootstrap container component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return one Bootstrap container
 :)
declare %public function bootstrap:container(
  $parameter as item()*
) as element(div)
{
  element div {
    attribute class {
      "container"
    },
    $parameter
  }
};

(:~
 : A function to return a Bootstrap card component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return one Bootstrap card
 :)
declare %public function bootstrap:card(
  $parameter as item()*
) as element(div)
{
  element div {
    attribute class {
      "card"
    },
    $parameter
  }
};

(:~
 : A function to return a Bootstrap card layout.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $cards is a sequence of zero or more div elements
 : @param $layout is one string
 : @return one Bootstrap card layout
 :)
declare %public function bootstrap:card-layout(
  $cards as element(div)*,
  $layout as xs:string
) as element(div)
{
  element div {
    attribute class {
      if (
        $layout = "group"
        or $layout = "deck"
        or $layout = "columns"
      )
      then (
        "card-" || $layout
      )
      else (
        ""
      )
    },
    $cards
  }
};

(:~
 : A function to return a Bootstrap list group component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return one Bootstrap list group component
 :)
declare %public function bootstrap:list-group(
  $parameter as item()*
) as element(ul)
{
  element ul {
    attribute class {
      "list-group"
    },
    for $list-item at $number in $parameter
    return (
      element li {
        attribute class {
          "list-group-item"
        },
        element div {
          attribute class {
            "row"
          },
          element div {
            attribute class {
              "col-auto"
            },
            $number
          },
          element div {
            attribute class {
              "col"
            },
            $list-item
          }
        }
      }
    )
  }
};
