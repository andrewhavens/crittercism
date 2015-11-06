namespace :crittercism do
  desc 'Submit .dSYM to Crittercism'
  task :upload_dsym do
    Crittercism.upload_dsym
  end
end
