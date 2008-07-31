module SplitTesting
  class Feature < ActiveRecord::Base
    has_many :feature_testers, :class_name => 'SplitTesting::FeatureTester'
    
    def enable!
      self.update_attribute('enabled', true)
    end
    def disable!
      self.update_attribute('enabled', false)
    end
  end
end