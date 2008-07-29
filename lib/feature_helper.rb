module FeatureHelper
  def feature(name)
    feature = SplitTesting::Feature.find(:first, :conditions => {:name => name.to_s})
    raise "Feature '#{name}' not found" if feature.nil?
    yield if feature.enabled?
  end
end