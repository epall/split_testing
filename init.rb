require 'acts_as_tester'

# Include hook code here
ActionView::Base.send :include, FeatureHelper

ActiveRecord::Base.send :include, SplitTesting::Acts::Tester