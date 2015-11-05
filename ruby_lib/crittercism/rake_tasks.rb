namespace :crittercism do

  desc 'Zip .dSYM file'
  task :zip_dsym do
    puts 'Zipping dSYM file...'

    app_dsym = App.config.app_bundle('iPhoneOS') + '.dSYM'
    app_dsym_zip = app_dsym + '.zip'
    raise "Could not find dSYM file at #{app_dsym}" unless File.exist?(app_dsym)

    if !File.exist?(app_dsym_zip) or File.mtime(app_dsym) > File.mtime(app_dsym_zip)
      Dir.chdir(File.dirname(app_dsym)) do
        sh "/usr/bin/zip -q -r '#{File.basename(app_dsym)}.zip' '#{File.basename(app_dsym)}'"
      end
    end
  end

  desc 'Submit .dSYM to Crittercism'
  task :upload_dsym => :zip_dsym do
    require 'net/http'
    require 'net/http/post/multipart'
    puts 'Submitting dSYM to Crittercism...'

    app_dsym = App.config.app_bundle('iPhoneOS') + '.dSYM'
    app_dsym_zip = app_dsym + '.zip'
    raise "Could not find dSYM file at #{app_dsym}" unless File.exist?(app_dsym)

    uri = URI.parse("https://api.crittercism.com/api_beta/dsym/#{App.config.crittercism_app_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post::Multipart.new(uri.path,
      'dsym' => UploadIO.new(app_dsym_zip, 'application/zip', 'dsym.zip'),
      'key' => App.config.crittercism_api_key
    )
    response = http.request(request)

    puts "Crittercism Response: #{response.code} #{response.message}"
    p response.body unless /^2\d+/.match("#{response.code}")
  end
end
