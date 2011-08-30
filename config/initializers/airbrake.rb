Airbrake.configure do |config|
  config.api_key = YAML.load_file(Rails.root.join('config', 'airbrake.yml'))['api_key']
end
