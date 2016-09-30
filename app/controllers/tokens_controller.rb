# # come back to Twilio API
# twilioBaseURL = "https://api.twilio.com/2010-04-01"

get "/tokens" do
  get_tokens
end

def get_tokens
  p Twilio::Util::AccessToken.new(
    ENV['ACCOUNT_SID'],
    ENV['API_KEY_SID'],
    ENV['API_KEY_SECRET'],
    3600,
    current_user.user_name
  )
end

def get_grant
  if current_user
  grant = Twilio::Util::AccessToken::IpMessagingGrant.new

  grant.endpoint_id = "Community:#{current_user.user_name.gsub(" ", "_")}:browser"
  grant.service_sid = ENV['IPM_SERVICE_SID']
  grant
  end
end

post "/tokens" do
  if current_user
  p "It got to the create method"
  token = get_tokens
  grant = get_grant
  token.add_grant(grant)
  {username: current_user.user_name, token: token}.to_json
  end
end
