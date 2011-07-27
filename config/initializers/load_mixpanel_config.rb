raw_config = File.read(RAILS_ROOT + "/config/mixpanel_config.yml")
MIXPANEL_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys