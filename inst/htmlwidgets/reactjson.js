HTMLWidgets.widget({

  name: 'reactjson',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

          // add scroll to widget container for better sizing behavior
          el.style.overflow = "auto";

          ReactDOM.render(
            React.createElement(
              reactJsonView.default,
              {
                src: (typeof(x.data)==="string") ? JSON.parse(x.data) : x.data,
                name: x.name,
                theme: x.theme,
                iconStyle: x.iconStyle,
                indentWidth: x.indentWidth,
                collapsed: x.collapsed,
                collapseStringsAfterLength: x.collapseStringsAfterLength,
                groupArraysAfterLength: x.groupArraysAfterLength,
                enableClipboard: x.enableClipboard,
                displayObjectSize: x.displayObjectSize,
                displayDataTypes: x.displayDataTypes,
                onEdit: x.onEdit ? x.onEdit : function(value) {logChange(value,"edit")},
                onAdd: x.onAdd ? x.onAdd : function(value) {logChange(value,"add")},
                onDelete: x.onDelete ? x.onDelete : function(value) {logChange(value,"delete")},
                onSelect: x.onSelect ? x.onSelect : function(value) {logChange(value,"select")},
                sortKeys: x.sortKeys
              }
            ),
            el
          );

          function logChange( value, eventname ){
            if(typeof(Shiny) !== "undefined" && Shiny.onInputChange){
              Shiny.onInputChange(el.id + "_" + eventname, {value:value});
            }
          }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
