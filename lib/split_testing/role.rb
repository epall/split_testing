module SplitTesting
  class Role < ActiveRecord::Base
    has_and_belongs_to_many :features, :class_name => 'SplitTesting::Feature'
  end
end