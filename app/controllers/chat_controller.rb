# display a list of all chats
get '/chats' do
  @chats = Chat.all #define instance variable for view
  erb :'index' #show all chats view (index)
end

# display a specific chat
get '/chats/:id' do
  @chat = Chat.find(params[:id]) #define instance variable for view

# ap response = HTTParty.get('https://api.twilio.com/2010-04-01')
  erb :'/chats/spiritual' # show single chat view
end

