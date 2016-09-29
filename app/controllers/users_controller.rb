# SHOW HTML FORM FOR NEW USER
get '/users/new' do
  if request.xhr?
    erb :'/users/_registerForm', layout: false
  else
  erb :'users/new' #show all users view (index)
  end
end

# NEW USER CREATE
post '/users' do
  p params
  @user = User.create(user_name: params[:user_name], first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])

  if @user
    session[:user_id] = @user.id
     redirect "/"
  else
    @errors = "Invalid login information. Please try again"
    erb :'sessions/new'
  end
end

# DISPLAY SPECIFIC USER
get '/users/:id' do
  #gets params from url
  @user = User.find(params[:id]) #define instance variable for view

  erb :'users/show' #show single user view
end

