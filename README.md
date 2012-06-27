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
    success: function(){},     // Success callback. If validation passed
    error: function(){}        // Server error callback
  });
```

Or a single success callback function:

``` javascript
  $('#form').ajaxForm(function(){
    window.location.href = '/some_url';
  });
```

Optionaly you can specify `redirect`  option in server response. So if JSON response contains `redirect: '/some_url'` 
it would be automaticaly triggered without any additional callbacks or configuration