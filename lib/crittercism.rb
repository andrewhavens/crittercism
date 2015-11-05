module Motion
  module Project
    class Config
      variable :crittercism_app_id, :crittercism_api_key
    end
  end
end

Motion::Project::App.setup do |app|
  app.pods do
    pod 'CrittercismSDK', '5.3.0' # any higher conflicts with New Relic, resulting in duplicate symbol errors
  end

  # TODO: add runtime support for fetching configured App ID
  # app.files << 'rubymotion_lib/crittercism.rb'
end

require "crittercism/rake_tasks"
