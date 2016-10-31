# react-json
A JSON editor packed as a React.js component, but also the simplest way of creating web forms.

[Play safe with react-json forms in the playground](http://codepen.io/arqex/pen/rVWYgo?editors=001).

React-json is like having an special input type for JSON objects, developers only need to listen to changes in the JSON instead of writing all the boilerplate needed to handle every single input of the form. It comes with top features:
* Field type guessing for quick forms
* Validation
* Styles easily customizable
* Extensible with custom field types

## Examples
Do you want to edit some JSON in your app? Pass it to the Json component:
```js
var doc = {
  hola: "amigo",
  array: [1,2,3]
};

React.render(
  <Json value={ doc } onChange={ logChange } />,
  document.body
);

function logChange( value ){
   console.log( value );
}
```
[See this example working](http://codepen.io/arqex/pen/rVWYgo?editors=001)

## A simple form creator
Do you hate creating forms? React-json handles all the dirty markup for you, and makes you focus in what is important;
```js
var doc = {
  user: "",
  password: ""
};

// form: true
// make objects not extensible,
// fields not removable
// and inputs always visible
var settings = {
  form: true,
  fields: { password: {type: 'password'} }
};

React.render(
  <Json value={ doc } settings={ settings }/>, 
  document.body
);
```
[See this form working](http://codepen.io/arqex/pen/xGRpOx?editors=011)

## Docs
React JSON is highly configurable, have a look at the docs to discover how.

## MIT licensed
[License here](LICENSE)
