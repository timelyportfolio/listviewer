# listviewer
A package of R htmlwidgets to interactively view *and maybe modify* `lists`.  As of now, `listviewer` provides just one interface to [`jsoneditor`](https://github.com/josdejong/jsoneditor).  `listviewer` is designed though to support multiple interfaces.

### install
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
