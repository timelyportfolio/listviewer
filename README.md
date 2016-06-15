[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/listviewer)](https://cran.r-project.org/package=listviewer) [![Travis-CI Build Status](https://travis-ci.org/timelyportfolio/listviewer.svg?branch=master)](https://travis-ci.org/timelyportfolio/listviewer)

# listviewer
A package of R htmlwidgets to interactively view *and maybe modify* `lists`.  As of now, `listviewer` provides just one interface to [`jsoneditor`](https://github.com/josdejong/jsoneditor).  `listviewer` is designed though to support multiple interfaces.

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

### Shiny example

`listviewer` works with `Shiny` but the implementation is crude and likely to change.  Here is an example.  If you really want to use it, I would recommend `debouncing` the `change` callback.

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
      as.list( .GlobalEnv )
      ,"change" = htmlwidgets::JS('function(){
        console.log( event.currentTarget.parentNode.editor.get() )
      }')
    )
    
  })
}

runApp( list( ui = ui, server = server ) )

```

### code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
