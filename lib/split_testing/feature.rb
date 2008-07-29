module SplitTesting
  class Feature < ActiveRecord::Base
    def enable
      self.update_attribute('enabled', true)
    end
    def disable
      self.update_attribute('enabled', false)
    end
  end
end