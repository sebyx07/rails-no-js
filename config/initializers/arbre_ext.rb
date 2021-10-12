module Arbre
  class Context
    alias_method :default_method_missing, :method_missing

    def method_missing(name, *args, **options, &block)
      begin
        default_method_missing(name, *args, **options, &block)
      rescue NoMethodError
        return super unless is_snab_class_available?(name.to_s)

        self.class.class_eval <<-RUBY
def #{name}(*args, **options, &block)
  ComponentLoader.new("#{name}").render(*args, **options, &block)
end
        RUBY

        ComponentLoader.new(name).render(*args, **options, &block)
      end
    end

    def is_snab_class_available?(name)
      component_files = Dir.glob(::Rails.root.join("app/assets/javascripts/components/**/*.js.rb")).select { |e| File.file? e }.map do |f_name|
        f_name.split("/app/assets/javascripts/components/").last.sub(".js.rb", "").split("/").map(&:camelize).join("::")
      end

      component_files.include?(name)
    end
  end
end