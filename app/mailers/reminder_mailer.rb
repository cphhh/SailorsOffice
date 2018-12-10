require 'digest/sha2'
class ReminderMailer < ApplicationMailer
  default from: 'tinto@bischof.dk'
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@bischof.dk"

  def invoice_reminder(regatta, user)
    @regatta = regatta
    @user = user
    mail(to: user.email, subject: "Please submit invoices from #{regatta.name} regatta")
  end
end
