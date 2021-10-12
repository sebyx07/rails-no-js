module ComponentHtmlHelper
  AUTO_BUILD_ELEMENTS = [ :a, :abbr, :address, :area, :article, :aside, :audio, :b, :base,
                          :bdo, :blockquote, :body, :br, :button, :canvas, :caption, :cite,
                          :code, :col, :colgroup, :command, :datalist, :dd, :del, :details,
                          :dfn, :div, :dl, :dt, :em, :embed, :fieldset, :figcaption, :figure,
                          :footer, :form, :h1, :h2, :h3, :h4, :h5, :h6, :head, :header, :hgroup,
                          :hr, :html, :i, :iframe, :img, :input, :ins, :keygen, :kbd, :label,
                          :legend, :li, :link, :map, :mark, :menu, :menuitem, :meta, :meter, :nav, :noscript,
                          :object, :ol, :optgroup, :option, :output, :param, :pre, :progress, :q,
                          :s, :samp, :script, :section, :select, :small, :source, :span,
                          :strong, :style, :sub, :summary, :sup, :svg, :table, :tbody, :td,
                          :textarea, :tfoot, :th, :thead, :time, :title, :tr, :track, :ul, :var, :video, :wbr ]

  HTML5_ELEMENTS = [ :para ] + AUTO_BUILD_ELEMENTS

  private

  def method_missing(name, *argv, **options, &block)
    return super unless HTML5_ELEMENTS.include?(name)

    value = block_given? ? block.call : argv
    native_value = Native(value)
    improved_options_class(options)
    improve_events(options)

    if !native_value.is_a?(String) && !native_value.is_a?(Array)
      value = [value]
    end

    return h(:p, options, value) if name == :para
    h(name, options, value)
  end

  def improved_options_class(options)
    return unless options[:class].is_a?(String)
    result = {}
    options[:class].split(" ").each do |class_name|
      result[class_name] = true
    end

    options[:class] = result
  end

  def improve_events(options)
    return unless options[:on]
    result = {}

    options[:on].each do |event_name, existing_value|
      if `typeof existing_value === 'function'`
        next result[event_name] = existing_value
      end

      next unless `Array.isArray(existing_value)`
      the_function = existing_value.find do |val|
        val.is_a?(Proc)
      end
      other_values = existing_value.filter do |val|
        val != the_function
      end

      result[event_name] = ->(ev) do
        the_function.call(ev, *other_values)
      end
    end

    options[:on] = result
  end
end
