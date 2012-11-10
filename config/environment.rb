# Load the rails application
require File.expand_path('../application', __FILE__)

# Mailer stuff
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true

# Initialize the rails application
Venti5sera::Application.initialize!
