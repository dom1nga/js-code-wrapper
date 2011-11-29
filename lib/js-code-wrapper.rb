require 'nokogiri'

module JsCodeWrapper
  def wrap_js_code(text)
    doc = ::Nokogiri::HTML("<text>#{text}</text>")
    doc.xpath("//script[not(ancestor::code)] | //*[@*[starts-with(name(), 'on')]]").wrap('<code>')
    doc.xpath("//body/*").to_s.scan(/<text>(.*)<\/text>/im)[0][0]
  end
end

Object.send(:include, JsCodeWrapper)
ActionView::Base.send(:include, JsCodeWrapper) if defined?(ActionView::Base)
