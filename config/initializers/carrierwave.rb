if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AWS_ACCESS_KEY_ID',
      aws_secret_access_key: 'AWS_SECRET_ACCESS_KEY',
      region: 'AWS_REGION'
    }
  
    
      config.fog_directory  = ENV['AWS_BUCKET_NAME']
      config.asset_host = ENV['AWS_BUCKET_URL']
  end
end