ActionMailer::Base.smtp_settings = {
  :address            	=> ENV["SMTP_SERVER"], 
  :port               	=> ENV["SMTP_PORT"].to_i, 
  :user_name          	=> ENV["SMTP_USERNAME"],
  :password           	=> ENV["SMTP_PASSWORD"], 
  :authentication				=> ENV["SMTP_AUTHENTICATION"],
  :enable_starttls_auto	=> ENV["SMTP_ENABLE_STARTTLS_AUTO"],
  :openssl_verify_mode	=> ENV["SMTP_OPENSSL_VERIFY_MODE"],
}

# ActionMailer::Base.default_url_options[:host] = "localhost:3000"
require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?