ActionMailer::Base.smtp_settings = {
  :address              => ENV["SMTP_SERVER"], 
  :port                 => ENV["SMTP_PORT"].to_i, 
  :user_name            => ENV["SMTP_USERNAME"],
  :password             => ENV["SMTP_PASSWORD"], 
}

# ActionMailer::Base.default_url_options[:host] = "localhost:3000"
require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?