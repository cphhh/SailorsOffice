module SlackHelper

  def request_verified?
    timestamp = request.headers["X-Slack-Request-Timestamp"]
    signature = request.headers["X-Slack-Signature"]
    signing_secret = ENV["SLACK_SECRET"]

    if Time.at(timestamp.to_i) < 5.minutes.ago
      return false # expired
    end

    basestring = "v0:#{timestamp}:#{request.body.read}"
    my_signature = "v0=#{OpenSSL::HMAC.hexdigest("SHA256", signing_secret, basestring)}"

    ActiveSupport::SecurityUtils.secure_compare(my_signature, signature)
  end
end
