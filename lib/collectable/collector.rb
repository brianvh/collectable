module Collectable
  module Collector

    def collectable(options = {})
      @@collectable_options = {}
      collectable_config(options)

      class_eval <<-EOV
        @@subclasses = []

        def self.inherited(subclass)
          super
          @@subclasses << subclass
        end

        #{collect_subclasses}
        #{require_subclasses}
      EOV
    end

    def collect_subclasses
      return '' unless collectable_options[:group]
      %(
        @@#{collectable_options[:group]} = {}

        def self.#{collectable_options[:group]}
          @@#{collectable_options[:group]}.empty? and @@subclasses.each do |klass|
            @@#{collectable_options[:group]}[klass.#{collectable_options[:single]}] = klass
          end
          @@#{collectable_options[:group]}
        end
      )
    end

    def collectable_key(name)
      class_eval <<-EOV
        def self.#{collectable_options[:single]}
          #{name.inspect}
        end
      EOV
    end

    def require_subclasses
      return '' unless collectable_options[:folder]
      %(
        Dir["#{collectable_options[:folder]}/*.rb"].each do |file|
          require file
        end
      )
    end

    def collectable_options
      @@collectable_options
    end

    def collectable_config(options = {})
      collectable_options[:group] = options[:into]
      collectable_options[:single] = options[:into].to_s.singularize
      collectable_options[:folder] = options[:from]
    end

  end
end
