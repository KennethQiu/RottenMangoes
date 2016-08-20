class UserMailer < ApplicationMailer

  default from: 'kennethqiujunhao@gmail.com'

  def account_delete_notice(user)
    @user = user
    mail(to: @user.email, subject: 'Your account at Rotton Mangoes is Deleted')
  end
end
