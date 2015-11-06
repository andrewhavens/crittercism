module Crittercism
  module BuilderExtensions
    def silent_execute_and_capture
      Crittercism.upload_dsym
      super
    end
  end
end

module Motion
  module Project
    class Builder
      prepend Crittercism::BuilderExtensions
    end
  end
end

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
