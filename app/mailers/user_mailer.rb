class UserMailer < ActionMailer::Base
  default from: 'venti5sera <noreply@venti5sera.herokuapp.com>'
  default_url_options[:host] = Rails.env.development? ? "localhost:3000" : "venti5sera.herokuapp.com"

  def registration_confirmation(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.registration_confirmation'))
  end

  def new_user_created(user)
    @user = user    
    admin = User.where("admin = ?", true).first
    mail(to: "#{admin.name} <#{admin.email}>", subject: t('user_mailer.subject.new_user_created'))
  end

  def start_following(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.start_following'))
  end

  def stop_following(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.stop_following'))
  end

  def new_desire(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.new_desire'))
  end

  def removed_desire(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.removed_desire'))
  end

  def updated_desire(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.updated_desire'))
  end

  def password_reset_instructions(user)
    @user = user
    mail(to: "#{user.name} <#{user.email}>", subject: t('user_mailer.subject.reset_password'))    
  end

end
