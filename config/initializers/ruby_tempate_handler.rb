ActiveSupport.on_load :action_view do
  ActionView::Template.register_template_handler(*%i(arb rb), Arbre::Rails::TemplateHandler.new)
end