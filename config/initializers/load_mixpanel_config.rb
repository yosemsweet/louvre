raw_config = File.read(::Rails.root.to_s + "/config/mixpanel_config.yml")
MIXPANEL_CONFIG = YAML.load(raw_config)[::Rails.env.to_s].symbolize_keys