module SplitTesting
  module Acts
    module Tester
      def self.included(mod)
        mod.extend(ClassMethods)
        # SplitTesting::Feature.send :has_many, :testers, {:through => :feature_tester, :class_name => mod.name}
      end
      
      module ClassMethods
        def acts_as_tester
          extend SplitTesting::Acts::Tester::SingletonMethods
          include SplitTesting::Acts::Tester::InstanceMethods
        end
      end
      
      module SingletonMethods
      end
      
      module InstanceMethods
      end
    end
  end
end