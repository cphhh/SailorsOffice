class ReminderMailer < ApplicationMailer
  default from: 'tinto@bischof.dk'

  def invoice_reminder(regatta, user)
    @regatta = regatta
    @user = user
    mail(to: user.email, subject: "Please submit invoices from #{regatta.name} regatta")
  end
end
