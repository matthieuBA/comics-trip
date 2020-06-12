# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings =   {
    port: 587,
    address: 'smtp.gmail.com',
    user_name: ENV['GMAIL_LOGIN'],
    password: ENV['GMAIL_PWD'],
    authentication: :plain,
    enable_starttls_auto: true
  }
