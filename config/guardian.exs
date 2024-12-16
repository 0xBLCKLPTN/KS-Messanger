use Guardian, otp_app: :ks_messanger

config :guardian,
  issuer: "ks_messanger",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "your_secret_key",
  serializer: KsMessanger.GuardianSerializer