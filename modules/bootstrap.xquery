xquery version "3.1" encoding "UTF-8";

(:~
 : The MVC-XQuery Bootstrap v4.1.3 function library module.
 :
 : MVC-XQuery | A Model-View-Controller framework for BaseX
 : Copyright (C) 2018 Adam Steffanick
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v0.2.1
 : @see https://github.com/AdamSteffanick/mvc-xquery
 : February 11, 2019
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
 : A function to return required Bootstrap meta elements.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.2.0
 :
 : @return a sequence of required Bootstrap meta elements
 :)
declare function bootstrap:meta(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @return one Bootstrap link element referencing an external stylesheet
 :)
declare function bootstrap:stylesheet(
) as element(link)
{
  element link {
    attribute rel {
      "stylesheet"
    },
    attribute href {
      "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
    },
    attribute integrity {
      "sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @return a sequence of Bootstrap script elements referncing external JavaScript
 :)
declare function bootstrap:javascript(
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
      "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
    },
    attribute integrity {
      "sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
    },
    attribute crossorigin {
      "anonymous"
    }
  },
  element script {
    attribute src {
      "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
    },
    attribute integrity {
      "sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $parameter is a string
 : @return one Bootstrap navbar brand as a heading
 :)
declare function bootstrap:navbar-brand(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $parameter is a CSV string with header values: parent,loc,name
 : @return one Bootstrap navbar ul element
 :)
declare function bootstrap:navbar-ul(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @return one Bootstrap navbar search form
 :)
declare function bootstrap:navbar-search(
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

(:~
 : A function to return a Bootstrap navbar component.
 :
 : @author Adam Steffanick
 : @see https://www.steffanick.com/adam/
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $parameter is one Bootstrap navbar ul element
 : @return one Bootstrap navbar
 :)
declare function bootstrap:navbar(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return one Bootstrap container
 :)
declare function bootstrap:container(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return one Bootstrap card
 :)
declare function bootstrap:card(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $cards is a sequence of zero or more div elements
 : @param $layout is one string
 : @return one Bootstrap card layout
 :)
declare function bootstrap:card-layout(
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
 : @version v1.0.0
 : @since v0.2.0
 :
 : @param $parameter is a sequence of zero or more items
 : @return one Bootstrap list group component
 :)
declare function bootstrap:list-group(
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
