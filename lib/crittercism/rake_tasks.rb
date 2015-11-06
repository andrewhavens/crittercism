namespace :crittercism do
  desc 'Upload dSYM file to Crittercism'
  task :upload_dsym do
    Crittercism.upload_dsym
  end
end
