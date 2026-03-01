# config/initializers/rack_attack.rb

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle('req/ip', limit: 10, period: 1.minute) do |req|
  puts "Throttling request from IP: #{req.ip}"
  req.ip
end

Rack::Attack.throttle('logins/ip', limit: 2, period: 30.seconds) do |req|
  if req.path == '/api/v1/sessions' && req.post?
    req.ip
  end
end

Rack::Attack.throttled_responder = lambda do |req|
  [429, {}, ['Too many requests. Please try again later.']]
end

