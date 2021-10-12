html do
  head do
    title { "Rails No JS" }
    meta(name: "viewport", content: "width=device-width,initial-scale=1")

    text_node csrf_meta_tags
    text_node csp_meta_tag
    text_node(stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload')
    # text_node(javascript_include_tag 'native-js', media: 'all', 'data-turbolinks-track': 'reload')
    script src: 'https://code.jquery.com/jquery-3.3.1.min.js'
    text_node(javascript_include_tag 'application', media: 'all', 'data-turbolinks-track': 'reload')
  end

  body do
    yield
  end
end
