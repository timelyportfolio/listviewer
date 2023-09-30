HTMLWidgets.widget({

  name: 'jsonedit',

  type: 'output',

  initialize: function(el, width, height) {

    return { editor: null  }

  },

  renderValue: function(el, x, instance) {

    // clear out our element in case of dynamic
    //   probably a sloppy way of doing it but easy and dependency-free
    //   feel free to make suggestions
    el.innerHTML = "";

    // create our editor
    var editor = new JSONEditor.JSONEditor({
      target: el,
      props: {
        content: (typeof(x.data)==="string") ? {text: x.data} : {json: x.data},
        ...x.options
      }
    });

    // use expando property to store editor for change callback potential
    instance.editor = editor;

  },

  resize: function(el, width, height, instance) {

  }

});
