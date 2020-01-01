xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery Bootstrap v4.3.1 function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework in XQuery for BaseX
 : Copyright (C) 2018–2020 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.5.0
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : January 1, 2020
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

(: required function library modules :)
import module namespace html5 = "html5" at "html5.xquery";

(:~
 : A public variable containing minimal Bootstrap template requirements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.1
 : @since v0.2.2
 :
 : @return one MVC-XQuery template map item with Bootstrap requirements
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
 : A public function to return required Bootstrap meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
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
 : A public function to return Bootstrap CSS.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.1.0
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
 : A public function to return Bootstrap optional JavaScript.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.1.0
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
      "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
    },
    attribute integrity {
      "sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
    },
    attribute crossorigin {
      "anonymous"
    }
  },
  element script {
    attribute src {
      "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
    },
    attribute integrity {
      "sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
    },
    attribute crossorigin {
      "anonymous"
    }
  }
};

(:~
 : A public function to return a Bootstrap navbar component brand.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.1.0
 : @since v0.2.0
 :
 : @param $parameter is a string
 : @return one Bootstrap navbar brand as an a element
 :)
declare %public function bootstrap:navbar-brand(
  $parameter as xs:string
) as element(a)
{
  html5:element(
    map {
      "name" : "a",
      "attributes" : map {
        "class" : "navbar-brand",
        "href" : "/"
      },
      "content" : $parameter
    }
  )
};

(:~
 : A public function to return a Bootstrap navbar component list.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.0.0
 : @since v0.2.0
 :
 : @param $parameter is a sequence of one or more MVC-XQuery path elements
 : @return one Bootstrap navbar ul element
 :)
declare %public function bootstrap:navbar-ul(
  $parameter as element(path)*
) as element(ul)
{
  html5:element(
    map {
      "name" : "ul",
      "attributes" : map {
        "class" : "navbar-nav mr-auto mt-2 mt-lg-0"
      },
      "content" : (
        for $path in $parameter
        where (
          fn:data($path/@segments) < 2
        )
        return (
          if (
            $path/text() = $parameter/@parent
            and $path/text() != "/"
          )
          then (
            html5:element(
              map {
                "name" : "li",
                "attributes" : map {
                  "class" : "nav-item dropdown"
                },
                "content" : (
                  html5:element(
                    map {
                      "name" : "a",
                      "attributes" : map {
                        "class" : "nav-link dropdown-toggle",
                        "href" : "#",
                        "id" : fn:replace("navbar-" || $path/text(), "/", ""),
                        "role" : "button",
                        "data-toggle" : "dropdown",
                        "aria-haspopup" : "true",
                        "aria-expanded" : "false"
                      },
                      "content" : (
                        fn:data($path/@title)
                      )
                    }
                  ),
                  html5:element(
                    map {
                      "name" : "div",
                      "attributes" : map {
                        "class" : "dropdown-menu",
                        "aria-labelledby" : fn:replace("navbar-" || $path/text(), "/", "")
                      },
                      "content" : (
                        html5:element(
                          map {
                            "name" : "a",
                            "attributes" : map {
                              "class" : "dropdown-item",
                              "href" : $path/text()
                            },
                            "content" : fn:data($path/@title)
                          }
                        ),
                        for $child in $parameter
                        where (
                          fn:data($child/@parent) = $path/text()
                        )
                        return (
                          html5:element(
                            map {
                              "name" : "a",
                              "attributes" : map {
                                "class" : "dropdown-item",
                                "href" : $child/text()
                              },
                              "content" : fn:data($child/@title)
                            }
                          )
                        )
                      )
                    }
                  )
                )
              }
            )
          )
          else (
            html5:element(
              map {
                "name" : "li",
                "attributes" : map {
                  "class" : "nav-item"
                },
                "content" : html5:element(
                  map {
                    "name" : "a",
                    "attributes" : map {
                      "class" : "nav-link",
                      "href" : $path/text()
                    },
                    "content" : (
                      fn:data($path/@title)
                    )
                  }
                )
              }
            )
          )
        )
      )
    }
  )
};

(:~
 : A public function to return a Bootstrap navbar component search form.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v2.1.0
 : @since v0.2.0
 :
 : @param (optional) $parameter is a sequence of zero or one map items
 : @return one Bootstrap navbar search form
 :)
declare %public function bootstrap:navbar-search(
) as element(form)
{
  html5:element(
    map {
      "name" : "form",
      "attributes" : map {
        "class" : "form-inline my-2 my-lg-0"
      },
      "content" : (
        html5:element(
          map {
            "name" : "input",
            "attributes" : map {
              "class" : "form-control mr-sm-2",
              "type" : "search",
              "name" : "q",
              "placeholder" : "Search",
              "required" : "required",
              "aria-label" : "Search"
            }
          }
        ),
        html5:element(
          map {
            "name" : "button",
            "attributes" : map {
              "class" : "btn btn-outline-light my-2 my-sm-0",
              "type" : "submit",
              "formaction" : "/search/"
            },
            "content" : "Search"
          }
        )
      )
    }
  )
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
  let $placeholder := (
    if (
      map:get($parameter, "placeholder")
      => fn:empty()
    )
    then (
      "Search"
    )
    else (
      map:get($parameter, "placeholder")
    )
  )
  return (
    html5:element(
      map {
        "name" : "form",
        "attributes" : map {
          "class" : "form-inline my-2 my-lg-0"
        },
        "content" : (
          html5:element(
            map {
              "name" : "input",
              "attributes" : map {
                "class" : "form-control mr-sm-2",
                "type" : "search",
                "name" : $name,
                "placeholder" : $placeholder,
                "required" : "required",
                "aria-label" : $placeholder
              }
            }
          ),
          html5:element(
            map {
              "name" : "button",
              "attributes" : map {
                "class" : "btn btn-outline-light my-2 my-sm-0",
                "type" : "submit",
                "formaction" : $formaction
              },
              "content" : "Search"
            }
          )
        )
      }
    )
  )
};

(:~
 : A public function to return a Bootstrap navbar component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
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
 : A public function to return a Bootstrap container component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
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
 : A public function to return a Bootstrap card component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
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
 : A public function to return a Bootstrap card layout.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
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
 : A public function to return a Bootstrap list group component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.2
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
