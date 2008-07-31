module FeatureHelper
  def feature(name)
    feature = SplitTesting::Feature.find(:first, :conditions => {:name => name.to_s})
    raise "Feature '#{name}' not found" if feature.nil?
    
    if feature.enabled?
      if feature.restricted? && self.respond_to?(:current_user)
        yield if current_user && current_user.tester?(feature)
      else
        yield
      end
    end
  end
end