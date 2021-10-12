class SimpleList < ApplicationComponent
  needs :elements, store: true
  load_records :users, "UserRepository", :all

  def render
    remove_element = -> (_ev, el) do
      p el
    end

    div do
      [
        ul(class: "omg lol kkkk") do
          @elements.map do |el|
            li(on: { click: [remove_element, 1] }) do
              el
            end
          end
        end,
        ul(class: "omg lol kkkk") do
          @users.map do |el|
            li(on: { click: [remove_element, 1] }) do
              el
            end
          end
        end
      ]
    end
  end
end