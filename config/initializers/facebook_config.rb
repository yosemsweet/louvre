raw_config = File.read(RAILS_ROOT + "/config/facebook_config.yml")
FB_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys