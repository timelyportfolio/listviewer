[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/listviewer)](https://cran.r-project.org/package=listviewer) [![Travis-CI Build Status](https://travis-ci.org/timelyportfolio/listviewer.svg?branch=master)](https://travis-ci.org/timelyportfolio/listviewer)

# listviewer
A package of R htmlwidgets to interactively view *and maybe modify* `lists`.  As of now, `listviewer` provides an interface to [`jsoneditor`](https://github.com/josdejong/jsoneditor) and [`react-json-view`](https://github.com/mac-s-g/react-json-view).  `listviewer` is designed to support multiple interfaces.

### install

**CRAN**
```r
install.packages("listviewer")
```

**Development Version**
```r
devtools::install_github("timelyportfolio/listviewer")
```


### jsoneditor

[`jsoneditor`](https://github.com/josdejong/jsoneditor) is a really well designed `JSON` interactive editor by [Jos de Jong](http://josdejong.com/).  Since most `R` data can be represented in `JSON`, we can use this great `JavaScript` library in `R`.

```r
# using the data from the jsoneditor simple example
#  in R list form

library(listviewer)

jsonedit(
  list(
    array = c(1,2,3)
    ,boolean = TRUE
    ,null = NULL
    ,number = 123
    ,object = list( a="b", c="d" )
    ,string = "Hello World"
  )
)
```

```r
# also works with data.frames
jsonedit( mtcars )
```

```r
# helpful interactive view of par
jsonedit( par() )
```

```r
# meta view of the above
jsonedit(jsonedit(par()))
```

See the above [interactive view of par](http://bl.ocks.org/timelyportfolio/5186ed143f773063a077) for yourself.

I got this idea courtesy of @jasonpbecker on Twitter.  `htmlwidgets` dependencies are defined by `YAML`.  Let's see the dependencies for `jsonedit`.

```r
jsonedit(
  yaml.load_file(system.file("htmlwidgets/jsonedit.yaml",package="listviewer"))
)
```

How about `topojson`?

```r
### experiment with topojson
library(httr)
library(pipeR)
library(listviewer)

# topojson for Afghanistan
url_path = "https://gist.githubusercontent.com/markmarkoh/8856417/raw/6178d18115d9f273656d294a867c3f83b739a951/customAfghanMap.topo.json"

url_path %>>% 
  GET %>>%
  content( as = "text") %>>%
  jsonedit
```


### reactjson

[`react-json-view`](https://github.com/mac-s-g/react-json-view) is another very nice `JSON` interactive editor.  We even get copy/paste!  All of the above examples should also work with `reactjson`.

```r
# using the data from the jsoneditor simple example
#  in R list form

library(listviewer)

reactjson(
  list(
    array = c(1,2,3)
    ,boolean = TRUE
    ,null = NULL
    ,number = 123
    ,object = list( a="b", c="d" )
    ,string = "Hello World"
  )
)
```


### Shiny example

`listviewer` works with `Shiny` but the implementation is crude and likely to change for `jsonedit` while `reactjson` integration is much better.  If you really want to use `jsonedit` with `Shiny`, I would recommend `debouncing` the `change` callback.  Here are examples with each.

```r
library(shiny)
library(listviewer)

# put some data in environment so it will show up
data(mtcars)

ui <- shinyUI(
  fluidPage(
    jsoneditOutput( "jsed" )
  )
)

server <- function(input,output){
  output$jsed <- renderJsonedit({
    jsonedit(
      jsonlite::toJSON(mtcars, auto_unbox = TRUE, data.frame = "rows")
      ,"onChange" = htmlwidgets::JS('function(after, before, patch){
        console.log( after.json )
      }')
    )
    
  })
}

runApp( list( ui = ui, server = server ) )

```

```r
library(shiny)
library(listviewer)

# put some data in environment so it will show up
data(mtcars)

ui <- shinyUI(
  fluidPage(
    reactjsonOutput( "rjed" )
  )
)

server <- function(input,output){
  output$rjed <- renderReactjson({
    reactjson( jsonlite::toJSON(mtcars, auto_unbox = TRUE, data.frame = "rows") )
  })
  
  observeEvent(input$rjed_edit, {
    str(input$rjed_edit, max.level=2)
  })
}

runApp( list( ui = ui, server = server ) )

```


### code of conduct

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/timelyportfolio/listviewer/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.
