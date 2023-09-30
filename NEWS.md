# listviewer 4.0.0

* update `jsoneditor` to completely rebuilt [0.18.7](https://github.com/josdejong/svelte-jsoneditor/releases/tag/v0.18.7)

# listviewer 3.0.0

*API Changes*
- `onEdit`, `onAdd`, `onDelete`, and `onSelect` changed to allow disable.  See [pull 32](https://github.com/timelyportfolio/listviewer/pull/32).  The default `TRUE` now will
pass the event to Shiny if in Shiny context.

# listviewer 2.1.0

* update `jsoneditor` to [5.24.6](https://github.com/josdejong/jsoneditor/releases/tag/v5.24.6)
* update `react-json-view` to 2.5.7
* add full set of `props` for `react-json-view`

# listviewer 2.0.0

* change `reactjson()` to use [`react-json-view`](https://github.com/mac-s-g/react-json-view) instead of [`react-json`](https://github.com/arqex/react-json)

# listviewer 1.4.0

* add `elementId` to the `jsonedit` function
* update `react-json` to [`0.2.1`](https://github.com/arqex/react-json/releases/tag/0.2.1)
* add helper `number_unnamed` function (see [issue](https://github.com/timelyportfolio/listviewer/issues/18))

# listviewer 1.3

* add [react-json](https://github.com/arqex/react-json) as an alternate list viewer

# listviewer 1.2

* add RStudio addin capabilities

# listviewer 1.1

* add shiny gadget functionality with `jsonedit_gadget`

# listviewer 1.0

* Submit to CRAN.



