module SplitTesting
  module Acts
    module Tester
      def self.included(mod)
        mod.extend(ClassMethods)
        SplitTesting::Feature.send :has_many, :testers, {:through => :feature_tester, :class_name => mod.name}
        SplitTesting::FeatureTester.send :belongs_to, :tester, {:class_name => mod.name}
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
        def enable_tester(feature)
          feature = SplitTesting::Feature.find(:first, :conditions => {:name => feature.to_s})
          featuretester = SplitTesting::FeatureTester.find(:first, :conditions => {:tester_id => self.id, :feature_id => feature.id})
          featuretester ||= SplitTesting::FeatureTester.create(:tester => self, :feature => feature)
          featuretester.enable!
        end
        
        def disable_tester(feature)
          feature = SplitTesting::Feature.find(:first, :conditions => {:name => feature.to_s})
          featuretester = SplitTesting::FeatureTester.find(:first, :conditions => {:tester_id => self.id, :feature_id => feature.id})
          featuretester ||= SplitTesting::FeatureTester.create(:tester => self, :feature => feature)
          featuretester.disable!
        end
      end
    end
  end
end