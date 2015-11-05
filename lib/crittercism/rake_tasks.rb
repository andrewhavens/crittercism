namespace :crittercism do

  def platform
    # FIXME: need to be able to fetch this dynamically
    'iPhoneOS'
  end

  def app_dsym
    App.config.app_bundle(platform) + '.dSYM'
  end

  desc 'Zip .dSYM file'
  task :zip_dsym do
    puts 'Zipping dSYM file...'
    raise "Could not find dSYM file at #{app_dsym}" unless File.exist?(app_dsym)

    app_dsym_zip = app_dsym + '.zip'
    if !File.exist?(app_dsym_zip) or File.mtime(app_dsym) > File.mtime(app_dsym_zip)
      Dir.chdir(File.dirname(app_dsym)) do
        sh "/usr/bin/zip -q -r '#{File.basename(app_dsym)}.zip' '#{File.basename(app_dsym)}'"
      end
    end
  end

  desc 'Submit .dSYM to Crittercism'
  task :upload_dsym => :zip_dsym do
    puts 'Submitting dSYM to Crittercism...'

    upload_uri = "https://api.crittercism.com/api_beta/dsym/#{App.config.crittercism_app_id}"
    command = "/usr/bin/curl #{upload_uri}"\
                 " --silent --output /dev/null -w '%{http_code}'"\
                 " -F dsym=@'#{app_dsym}.zip'"\
                 " -F key='#{App.config.crittercism_api_key}'"

    output = %x[#{command}]
    if output =~ /^2\d+/
      puts 'Successfully uploaded dSYM to Crittercism.'
    else
      puts 'Failed to upload dSYM to Crittercism.'
      p output
      exit 1
    end
  end
end
