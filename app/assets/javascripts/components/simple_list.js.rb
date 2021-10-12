class SimpleList < ApplicationComponent
  needs :elements, store: true

  def render
    remove_element = -> (_, el) do
      el = Native(el)
      filtered_elements = @elements.filter do |element|
        element != el.text
      end

      store :elements, filtered_elements
    end

    div do
      ul(class: "omg lol kkkk") do
        @elements.map do |el|
          li(on: { click: [remove_element, el] }) do
            el
          end
        end
      end
    end
  end
end