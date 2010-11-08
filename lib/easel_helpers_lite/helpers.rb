module EaselHelpersLite
  module Helpers
    def body(*args)
      @_classes ||= []
      @_classes += args.select(&:present?).map do |arg|
        arg.to_s.strip
      end.uniq

      if block_given?
        attributes = {}
        attributes[:class] = @_classes.join(" ") if @_classes.length > 0
        content_tag(:body, capture {yield}, attributes)
      else
        nil
      end
    end

    def link_button(*args, &block)
      doc = Nokogiri(link_to(*args, &block))
      doc.at("a").inner_html = "<span>#{doc.at("a").inner_html}</span>"
      (doc/:a).add_class("btn")
      raw(doc.to_html)
    end

    def submit_button(*args, &block)
      button_text = args.first
      options = args.extract_options!
      klass = options[:class] || "btn"

      content_tag("button", :type => "submit", :class => klass) do
        if block_given?
          yield
        else
          content_tag("span", button_text)
        end
      end
    end
  end
end
