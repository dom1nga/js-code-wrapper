require 'nokogiri'
require 'cgi'

module JsCodeWrapper
  def wrap_js_code(text, options = { :escape_js => false })
    doc = ::Nokogiri::HTML("<text>#{text}</text>")
    if options[:escape_js]
      doc.xpath("//script[not(ancestor::code)] | //*[@*[starts-with(name(), 'on')]]").each {|elem| elem.replace(::CGI.escapeHTML(elem.to_html)) }
    else
      doc.xpath("//script[not(ancestor::code)] | //*[@*[starts-with(name(), 'on')]]").wrap('<code>')
    end
    doc.xpath("//body/*").to_s.scan(/<text>(.*)<\/text>/im)[0][0]
  end
  
  module_function :wrap_js_code
end

ActionView::Base.send(:include, JsCodeWrapper) if defined?(ActionView::Base)
