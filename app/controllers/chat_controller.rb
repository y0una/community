require 'twilio-ruby'
require 'sinatra'
# require 'sinatra/json'
require 'dotenv'

# Load environment configuration
Dotenv.load

# CHAT DISPLAY ALL LIST
get '/chats' do
  @chats = Chat.all #define instance variable for view
  erb :'index' #show all chats view (index)
end

# GENERATE TOKEN FOR USE IN IP MSGING APP
post '/tokens' do
  unless current_user
  redirect '/'
  else
  token = get_token
  # Create an Access Token for IP messaging usage
  # token = Twilio::Util::AccessToken.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_API_KEY'], ENV['TWILIO_API_SECRET'], 3600

  grant = get_grant
  # Create IP Messaging grant for our token
  # grant = Twilio::Util::AccessToken::IpMessagingGrant.new
  # grant.endpoint_id = "Chatty:#{current_user.name.gsub(" ", "_")}:browser"
  # grant.service_sid = ENV['IPM_SERVICE_SID']
  if current_user
  token.add_grant grant
  end
  # Generate token and send to client
  # json
  {:token => token.to_jwt, :username => current_user.user_name }.to_json
  # json :identity => identity, :token => token.to_jwt
  end

end


def get_token
  if current_user
  Twilio::Util::AccessToken.new(
    ENV['ACCOUNT_SID'],
    ENV['API_KEY_SID'],
    ENV['API_KEY_SECRET'],
    3600,
    current_user.user_name
  )
  end
end

def get_grant
  grant = Twilio::Util::AccessToken::IpMessagingGrant.new
  grant.endpoint_id = "Chatty:#{current_user.user_name.gsub(" ", "_")}:browser"
  grant.service_sid = ENV['IPM_SERVICE_SID']
  grant
end
  # Get user provided ID for connecting device
  # device_id = params['device']
  # Create unique ID for currently connecting device
  # endpoint_id = "TwilioDemoApp:#{identity}:#{device_id}"


# CREATE NEW CHAT
# post '/chats' do
#   @chat = Chat.new(params[:chat]) #create new chat
#   if @chat.save
#     redirect "/chats"
#   else
#     erb :'chats/new'
#   end
# end

# CHAT DISPLAY SPECIFIC
get '/chats/:id' do
  @chat = Chat.find(params[:id]) #define instance variable for view

  # ap response = HTTParty.get('https://api.twilio.com/2010-04-01')
  erb :'/show' # show single chat view
end

