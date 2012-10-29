class UserMailer < ActionMailer::Base
  default from: 'noreply@venti5sera.it'

  def registration_confirmation(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: "Registered")
  end

  def new_user_created(user)
    @user = user    
    admin = User.where("admin = ?", true).first
    mail(to: "#{admin.name} <#{admin.email}>", subject: "New User registration")
  end

  def start_following(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: "Someone is following you!")
  end

  def stop_following(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: "You are not followed anymore")
  end

  def new_desire(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: "There is a new Desire!")
  end

  def removed_desire(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: "A Desire has been removed!")
  end

  def updated_desire(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: "A Desire has been updated!")
  end

end
