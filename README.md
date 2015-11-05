# Crittercism

[Crittercism](http://www.crittercism.com/) is the easiest way (that I've found)
to add crash reporting to a RubyMotion application. This gem provides an even
easier way to integrate the Crittercism SDK into your project.

Currently, this gem only supports iOS projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crittercism'
```

And then execute:

    $ bundle && rake pod:install

## Usage

1. Register for a Crittercism account.
2. Register your app in Crittercism.
3. Find your `App ID` and `API Key` on the App Settings page.

In your Rakefile, specify your Crittercism App ID and API Key:

```ruby
Motion::Project::App.setup do |app|
  # ...
  app.crittercism_app_id = "YOUR_APP_ID"
  app.crittercism_api_key = "YOUR_API_KEY"
  # ...
end
```

Next, enable Crittercism within your `app_delegate.rb`:

```ruby
class AppDelegate
  def application(app, didFinishLaunchingWithOptions: options)
    Crittercism.enableWithAppID("YOUR_APP_ID")
    # ...
  end
end
```

Refer to the [Crittercism docs](http://docs.crittercism.com/ios/ios.html) for
information on how to use Crittercism's other features.

### Rake Task

You will need to upload your app's dSYM to Crittercism for symbolication.

    $ rake crittercism:upload_dsym

Typically, you will want to upload your dSYM every time you build your app.
You can configure your rake tasks to include this task.

```ruby
task :my_custom_deploy_task => ['archive:distribution', 'crittercism:upload_dsym']
```

<!--
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
-->

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewhavens/crittercism.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
