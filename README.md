# AjaxForm Plugin


This is jQuery plugin that helps submiting and validating your forms asynchronously. 
Keep your validation logic on server side, and for client side validate with javascript and AJAX.

## Usage

Using ajaxForm plugin is fairly easy:

Just include plugin script into `head` section within `script` tag. And then call:

``` javascript
  $('#form').ajaxForm();
```
Optionaly ajaxFom function takes a hash of paratmeters:

``` javascript
  $('#form').ajaxForm({
    errorClass: 'error-field', // Error class applied to field if it failed validation
    showErrorMessage: true,    // Show error messages or just highlight field 
    errorMessageFormat: '<div class="error-message">{message}</div>', // Error message markup.
    insertMessage: 'before',   // Error message position. Accepts 2 options 'before' and 'after'
    onSuccess: function(){},     // Success callback. If validation passed
    onErrors: function(){},  //is callback for successfull server response with array of validation errors
    onError: function(){},  //is server error callback
  });
```

Or a single success callback function:

``` javascript
  $('#form').ajaxForm(function(){
    document.location.href = '/some_url';
  });
```

Optionaly you can specify `redirect`  option in server response. So if JSON response contains `redirect: '/some_url'` 
it would be automaticaly triggered without any additional callbacks or configuration

## Backend

In order to make ajaxForm correctly apply validation errors to form, server should respond with JSON containing errors in speified format.

### Response example with errors:

```js
  {errors: {email: "Invalid email format", username: "Username is already taken"}}
```

Multiple errors can be specified to the same field. But only the first one will be shown as an error message.

```js
  {errors: {phone: ["Phone is too short", "Phone should be in numeric format"]}}
```

### Ruby on Rails

If you are using Rails, generating error hash is as simple as:

```ruby
  render :json => {:errors => @model.errors}
```
