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
  end
end
