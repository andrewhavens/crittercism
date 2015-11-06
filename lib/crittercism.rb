module Crittercism
  def self.platform
    # FIXME: need to be able to fetch this dynamically to support Android and Simulator environments.
    'iPhoneOS'
  end

  def self.upload_dsym
    app_id = App.config.crittercism_app_id
    api_key = App.config.crittercism_api_key
    unless app_id and api_key
      App.warn 'Missing Crittercism keys, skipping dSYM upload.'
      return
    end

    App.info 'Crittercism', 'Submitting dSYM to Crittercism...'
    zip_dsym!

    app_dsym = App.config.app_bundle_dsym(platform)
    upload_uri = "https://api.crittercism.com/api_beta/dsym/#{app_id}"
    command = "/usr/bin/curl #{upload_uri}"\
                 " --silent --output /dev/null -w '%{http_code}'"\
                 " -F dsym=@'#{app_dsym}.zip'"\
                 " -F key='#{api_key}'"

    output = %x[#{command}]
    if output =~ /^2\d+/
      App.info 'Crittercism', 'Successfully uploaded dSYM to Crittercism.'
    else
      p output
      App.fail 'Failed to upload dSYM to Crittercism.'
    end
  end

  def self.zip_dsym!
    app_dsym = App.config.app_bundle_dsym(platform)
    App.info 'Crittercism', 'Zipping dSYM file...'
    App.fail "Could not find dSYM file at #{app_dsym}" unless File.exist?(app_dsym)

    app_dsym_zip = app_dsym + '.zip'
    if !File.exist?(app_dsym_zip) or File.mtime(app_dsym) > File.mtime(app_dsym_zip)
      Dir.chdir(File.dirname(app_dsym)) do
        sh "/usr/bin/zip -q -r '#{File.basename(app_dsym)}.zip' '#{File.basename(app_dsym)}'"
      end
    end
  end
end

require "crittercism/rubymotion_extensions"
require "crittercism/rake_tasks"
