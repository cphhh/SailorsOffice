class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    user = params[:user_name]
    regatta_name = params[:channel_name]
    #regatta = Regatta.where(name: regatta_name)

    if user == 'maximilianbischof'
      user = 1
    end

    if user == 'christian'
      user = 2
    end

    if user == 'olewittenberg'
      user = 3
    end

    if user == 'bele.schuett'
      user = 4
    end

    if user == 'till.pomarius'
      user = 5
    end

    regattaid = Regatta.where(:name => regatta_name)[0][:id]

    timestamp = request.headers["X-Slack-Request-Timestamp"]
    signature = request.headers["X-Slack-Signature"]
    signing_secret = ENV["SLACK_SECRET"]

    basestring = "v0:#{timestamp}:#{request.body.read}"
    my_signature = "v0=#{OpenSSL::HMAC.hexdigest("SHA256", signing_secret, basestring)}"

    request_verified = ActiveSupport::SecurityUtils.secure_compare(my_signature, signature)

    if Time.at(timestamp.to_i) < 5.minutes.ago
      request_verified = false
    end

    if request_verified == true
      if Regatta.where(name: regatta_name).take.balances.first.closed == true
        render :plain => "Die Abrechnung für die #{regatta_name} Regatta wurde bereits am #{Regatta.where(name: regatta_name).take.balances.first.closing_date} geschlossen. Rechnung wurde nicht eingereicht."
      elsif Regatta.where(name: regatta_name).take.balances.first.closed == false
        Invoice.create(regatta_id: regattaid, user_id: user, name: words.first, price: words.second)
        render :plain => "Die Rechnung von #{words.first} bei der #{regatta_name} Regatta über #{words.second}€ wurde erstellt."
      end
    else
      render :plain => "Request nicht gültig."
    end
  end
end
