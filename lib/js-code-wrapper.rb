module JsCodeWrapper
  def wrap_js_code(text)
    code_coords = code_tag_coords(text)
    matches_count = script_to_code_tags_inclusion(text, code_coords).count {|t| !t[1]}

    while matches_count > 0 do
      text = insert_code_tags(text, code_coords)
      matches_count = matches_count - 1
      code_coords = code_tag_coords(text)
    end

    text
  end

  private

  def code_tag_coords(text)
    code_begin = text.to_enum(:scan,/(<code)/i).map { $`.size }
    code_end = text.to_enum(:scan,/(<\/code>)/i).map { $`.size }
    0.upto(code_begin.length - 1).map {|i| [code_begin[i], code_end[i]] }
  end

  def script_to_code_tags_inclusion(text, code_coords)
    text.to_enum(:scan,/(<script{1}[^<]*<\/script>{1})/i).map { $`.size }.map { |v| [v, code_coords.map{|c| c[0] < v && v < c[1] }.compact.any?] }
  end

  def insert_code_tags(text, code_coords)
    matches = text.gsub /(<script{1}[^<]*<\/script>{1})/i

    script_to_code_tags_inclusion(text, code_coords).each do |b|
      tmp = matches.next
      unless b[1]
        text[b[0]..(b[0]+tmp.length-1)] = '<code>'+ tmp +'</code>'
        return text
      end
    end
  end

end

Object.send(:include, JsCodeWrapper)
ActionView::Base.send(:include, JsCodeWrapper) if defined?(ActionView::Base)
