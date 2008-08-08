require 'rake'
require 'find'
require File.dirname(__FILE__) + '/../lib/feature_stripper'

desc 'Strip feature block from source files to expose the feature to everybody.'
task :stripfeature do
  feature = ENV['FEATURE']
  raise "no feature specified" unless feature
  Find.find(File.dirname(__FILE__) + '/../../../../app/views') do |path|
    unless FileTest.directory? path
      File.open(path, "r+") do |file|
        newcontents = FeatureStripper.strip(file.read, feature)
        file.reopen(path, "w")
        file << newcontents
      end
    end
  end
end