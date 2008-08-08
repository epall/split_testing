Split Testing Framework
=======================

Split testing (or A/B testing) is a powerful way of assessing the impact of features or changes on your user base. At its simplest, Split Testing Framework allows you to isolate chunks of view code inside "features" that can be turned on and off on a per-user or per-feature basis.


Example
=======

To wall off a section of view code as a feature
-----------------------------------------------
    <% feature :myfeature do -%>
    Super-cool beta feature
    <% end #feature:myfeature -%>

**NOTE:** the #feature:myfeature comment on the end tag is important for automatically stripping feature blocks out when you're cleaning up.

To strip feature block when you no longer need to restrict a feature
-----------------------------------------------
    rake stripfeature FEATURE=myfeature

To mark your user model as capable of testing features
------------------------------------------------------
    class User < ActiveRecord::Base
      acts_as_tester
    end

This gives you two methods to use for enabling and disabling features on a per-user basis:

    > User.find(:first).enable_tester('myfeature')
    > User.find(:first).disable_tester('myfeature')

If current_user is defined such that the `FeatureHelper` can call it, then the current user will be checked for tester access on top of the checking for whether the feature is enabled.

Copyright (c) 2008 Eric Allen, released under the MIT license
