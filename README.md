# js-code-wrapper #

Gem provides helper method 'wrap_js_code' that wraps javascript into '<code></code>' tags.

## Installation ##

Add
``` ruby
  gem 'js-code-wrapper'
```
to your `Gemfile`.

## Usage ##

``` ruby
  wrap_js_code("<script>alert('wrap me!');</script>") # => "<code><script>alert('wrap me!');</script></code>"
```
