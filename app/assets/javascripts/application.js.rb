require 'opal'
require 'turbolinks'
require 'native'
require 'snabberb'
require 'securerandom'
require 'json'
require_tree "./lib"
require_tree "./components"

$$[:document].addEventListener(:DOMContentLoaded, -> {
  $$[:document].querySelectorAll("[data-rails-no-js-component]").to_a.each do |el|
    component_name = el.dataset.railsNoJsComponent
    props = JSON.parse(el.dataset.props)
    el.id = component_id = SecureRandom.hex

    Object.const_get(component_name).attach(component_id, **props)
  end
})