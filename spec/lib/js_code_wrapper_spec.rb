require 'spec_helper'

describe JsCodeWrapper do

  describe "#wrap_js_code" do
    it "should return the text without changes, if it doesn't contains script tags" do
      JsCodeWrapper.wrap_js_code("text <p>text</p><h1>text</h1>").should ==
                   "text <p>text</p>\n<h1>text</h1>"
    end

    it "should return the text with script body (type1) wrapped into code tags" do
      JsCodeWrapper.wrap_js_code("<script>alert('wrap me!')</script>").should ==
                   "<code><script>alert('wrap me!')</script></code>"
    end

    it "should return the text with script body (type2) wrapped into code tags" do
      JsCodeWrapper.wrap_js_code('<script type="text/javascript" src="example.com/example.js"></script>').should ==
                   '<code><script type="text/javascript" src="example.com/example.js"></script></code>'
    end

    it "should return the text with script body wrapped into code tags when script body duplicated in text" do
      JsCodeWrapper.wrap_js_code('<code><script>alert("wrap me!")</script></code><script>alert("wrap me!")</script>').should ==
                   '<code><script>alert("wrap me!")</script></code><code><script>alert("wrap me!")</script></code>'
    end

    it "should return the text with script body wrapped into code tags" do
      JsCodeWrapper.wrap_js_code("<code><script>alert('wrap me1!')</script><script type='text/javascript' src='example.com/example1.js'></script></code><p>text1</p><script>alert('wrap me2!')</script><script type='text/javascript' src='example.com/example2.js'></script><code><script>alert('wrap me3!')</script></code>").should ==
                   "<code><script>alert('wrap me1!')</script><script type=\"text/javascript\" src=\"example.com/example1.js\"></script></code><p>text1</p>\n<code><script>alert('wrap me2!')</script></code><code><script type=\"text/javascript\" src=\"example.com/example2.js\"></script></code><code><script>alert('wrap me3!')</script></code>"
    end

    it "should return the text without changes, if script body into code tags" do
      JsCodeWrapper.wrap_js_code("<code><script>alert('wrap me!')</script></code>").should ==
                   "<code><script>alert('wrap me!')</script></code>"
    end

    it "should return the text with link wrapped into code tags if link contains event attribute" do
      JsCodeWrapper.wrap_js_code('<a href="#" onclick="alert(\'wrap me!\'); return 0;">link</a>').should ==
                   "<code><a href=\"#\" onclick=\"alert('wrap me!'); return 0;\">link</a></code>"
    end

    it "should return the text with tags without changes if tags not contains event attributes" do
      JsCodeWrapper.wrap_js_code('<a href="#">link</a><div class="div1"></div><p>text1</p>').should ==
                   "<a href=\"#\">link</a><div class=\"div1\"></div>\n<p>text1</p>"
    end
    
    it "should return the text with escaped java script" do
      JsCodeWrapper.wrap_js_code("<script>alert('wrap me!')</script>", :escape_js => true).should ==
                   "&lt;script&gt;alert('wrap me!')&lt;/script&gt;"
    end

  end
end
