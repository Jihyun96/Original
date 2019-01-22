require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AWS_ACCESS_KEY_ID',
      aws_secret_access_key: 'AWS_SECRET_ACCESS_KEY',
      region: 'AWS_REGION'
    }
  
    
      config.fog_directory  = ENV['AWS_BUCKET_NAME']
      
  end
else  CarrierWave.configure do |config|
  config.storage = :file
  end
end