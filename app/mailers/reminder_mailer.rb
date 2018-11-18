class ReminderMailer < ApplicationMailer
  default from: 'tinto@bischof.dk'

  def invoice_reminder(regatta)
    @regatta = regatta
    mail(to: regatta.users.first.email, subject: "Please submit invoices from #{@regatta.name} regatta")
  end
end
