module Crittercism
  module BuilderExtensions
    def build(config, platform, opts)
      super
      Crittercism.platform(platform)
      Crittercism.upload_dsym
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
      variable :crittercism_app_id, :crittercism_api_key, :crittercism_disable_on_simulator_builds
    end
  end
end

Motion::Project::App.setup do |app|
  app.pods do
    pod 'CrittercismSDK', '~> 5.4.0'
  end

  # TODO: add runtime support for fetching configured App ID
  # app.files << 'rubymotion_lib/crittercism.rb'
end
