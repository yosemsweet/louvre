raw_config = File.read(::Rails.root.to_s + "/config/roles.yml")
ROLES = YAML.load(raw_config).symbolize_keys
