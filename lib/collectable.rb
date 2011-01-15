require 'active_support/core_ext'

module Collectable
  def self.included(receiver)
    receiver.extend(ClassMethods)
  end

  module ClassMethods
    def collectable(options = {})
      @@subclass_group = options[:into]
      @@subclass_single = @@subclass_group.to_s.singularize
      @@subclass_folder = options[:from]

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
      return '' unless @@subclass_group
      %(
        @@#{@@subclass_group} = {}

        def self.#{@@subclass_group}
          @@#{@@subclass_group}.empty? and @@subclasses.each do |klass|
            @@#{@@subclass_group}[klass.#{@@subclass_single}] = klass
          end
          @@#{@@subclass_group}
        end
      )
    end

    def require_subclasses
      return '' unless @@subclass_folder
      %(
        Dir["#{@@subclass_folder}/*.rb"].each do |file|
          require file
        end
      )
    end

    def collectable_key(name)
      class_eval <<-EOV
        def self.#{@@subclass_single}
          #{name.inspect}
        end
      EOV
    end
  end
end
