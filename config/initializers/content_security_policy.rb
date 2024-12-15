if Rails.env.development?
  Rails.application.config.content_security_policy do |policy|
    policy.default_src :self, :https, :unsafe_inline, :unsafe_eval
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https, 'http://localhost:3001', :unsafe_inline
    policy.style_src   :self, :https
    policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035" if Rails.env.development?
  end
end

# Enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)
