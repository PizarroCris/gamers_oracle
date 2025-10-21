if ENV['CLOUDINARY_URL'].present?
  require 'cloudinary'
  require 'uri'

  begin
    Cloudinary.config_from_url(ENV['CLOUDINARY_URL'])
    Cloudinary.config.secure = true
  rescue StandardError => e
    Rails.logger.error "Cloudinary URL configuration failed: #{e.message}"
  end
end