module Arbre
  class Context
    alias_method :default_method_missing, :method_missing

    def method_missing(name, *args, **options, &block)
      begin
        default_method_missing(name, *args, **options, &block)
      rescue NoMethodError
        return super unless Object.const_defined?(name)
        klass = name.to_s.constantize
        return super unless klass.ancestors.include?(NoJsComponent)

        self.class.class_eval <<-RUBY
def #{name}(*args, **options, &block)
  #{name}.new(*args, **options, &block).render
end
        RUBY

        klass.new(*args, **options, &block).render
      end
    end
  end
end