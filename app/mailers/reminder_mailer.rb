class ReminderMailer < ApplicationMailer
  default from: 'tinto@bischof.dk'

  def invoice_reminder(regatta)
    mail(to: regatta.users.first.email, subject: 'Welcome to My Awesome Site')
  end
end
