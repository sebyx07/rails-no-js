class ComponentLoader
  include ActionView::Helpers::TagHelper
  def initialize(name)
    @component_name = name
  end

  def render(*args, **options, &block)
    data_options = {
      rails_no_js_component: @component_name,
      props: options[:props]
    }

    content_tag "div", nil, data: data_options
  end
end