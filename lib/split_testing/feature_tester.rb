module SplitTesting
  class FeatureTester < ActiveRecord::Base
    belongs_to :feature, :class_name => "SplitTesting::Feature", :foreign_key => 'feature_id'
    def enable!
      self.update_attribute('enabled', true)
    end
    def disable!
      self.update_attribute('enabled', false)
    end
  end
end