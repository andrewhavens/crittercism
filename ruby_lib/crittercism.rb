require "crittercism/version"
require "crittercism/rake_tasks"

# module Crittercism
#   # Your code goes here...
# end
puts 'loaded crittercism'
Motion::Project::App.setup do |app|
  app.pods do
    pod 'CrittercismSDK', '~> 5.4.0'
  end

  # TODO
  # app.files << 'rubymotion_lib/crittercism.rb'
end

module Motion
  module Project
    class Config
      variable :crittercism_app_id, :crittercism_api_key
    end
  end
end
