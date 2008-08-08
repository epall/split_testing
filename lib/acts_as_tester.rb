module SplitTesting
  module Acts
    module Tester
      def self.included(mod)
        mod.extend(ClassMethods)
      end
      
      module ClassMethods
        def acts_as_tester
          include SplitTesting::Acts::Tester::InstanceMethods
          SplitTesting::Feature.send :has_many, :testers, {:through => :feature_testers, :class_name => self.name}
          SplitTesting::FeatureTester.send :belongs_to, :tester, {:class_name => self.name}
          SplitTesting::Role.send :has_and_belongs_to_many, :testers, {:class_name => self.name}
          has_and_belongs_to_many :roles, :class_name => 'SplitTesting::Role', :join_table => 'roles_testers', :foreign_key => 'tester_id'
        end
      end
      
      module InstanceMethods
        def enable_tester(feature)
          feature = SplitTesting::Feature.find(:first, :conditions => {:name => feature.to_s})
          featuretester = feature.feature_testers.find(:first, :conditions => {:tester_id => self.id})
          featuretester ||= feature.feature_testers.create(:tester => self)
          featuretester.enable!
        end
        
        def disable_tester(feature)
          feature = SplitTesting::Feature.find(:first, :conditions => {:name => feature.to_s})
          featuretester = feature.feature_testers.find(:first, :conditions => {:tester_id => self.id})
          featuretester ||= feature.feature_testers.create(:tester => self)
          featuretester.disable!
        end
        
        def tester?(feature)
          if feature.is_a?(String) || feature.is_a?(Symbol)
            feature = SplitTesting::Feature.find_by_name(feature)
          end
          return false if feature.nil?
          
          feature_tester = feature.feature_testers.find(:first, :conditions => {:tester_id => self.id})
          return true if feature_tester && feature_tester.enabled?
          
          return !!roles.find(:all, :include => [:features]).detect {|r| r.features.include?(feature)}
        end
      end
    end
  end
end