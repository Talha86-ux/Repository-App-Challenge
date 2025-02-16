# config/initializers/jwt.rb
JWT_SECRET_KEY = ENV['JWT_SECRET']
JWT_ALGORITHM = 'HS256'