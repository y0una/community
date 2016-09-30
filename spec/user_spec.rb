require 'spec_helper'
require 'time'

describe User do
  describe "associations" do

    it "has a name" do
      @user_name = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @email = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @user = User.create!(user_name: @user_name, email: @email)

      expect(@user.user_name).to eq(@user_name)
    end

    it "has an email" do
      @user_name = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @email = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @user = User.create!(user_name: @user_name, email: @email)

      expect(@user.email).to eq(@email)
    end

    it "has a first name" do
      @user_name = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @email = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @user = User.create!(user_name: @user_name, email: @email, first_name: "Jane")
      expect(@user.first_name).to eq("Jane")
    end

    it "has a last name" do
      @user_name = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @email = Date.today.to_time.to_i.to_s + rand(10000).to_s
      @user = User.create!(user_name: @user_name, email: @email, first_name: "Jane", last_name: "Young")
      expect(@user.last_name).to eq("Young")
    end

    # it "doesn't store password in plain text" do
    #   @user_name = Date.today.to_time.to_i.to_s + rand(10000).to_s
    #   @email = Date.today.to_time.to_i.to_s + rand(10000).to_s
    #   @user = User.create!(user_name: @user_name, email: @email, password: "123")
    #   # expect(@user.password).not_to eq("123")
    #   expect(@user.password).not_to be == "123"
    # end

  end

end

describe Chat do
  describe "associations" do

    before(:each) do
      @chat = Chat.create!(interest: "hiking")
    end

    it "has an interest" do
      expect(@chat.interest).to eq("hiking")
    end

  end
end

# describe ChatsUser do
#   describe "associations" do

#     # before(:each) do
#     #   @chat = Chat.create!(interest: "hiking")
#     # end

#     it "has a chat id" do
#       @testchatsuser1 = ChatsUser.create!(chat_id:101)
#       # @chatsuser = ChatUser.create!()
#       expect(@testchatsuser1.chat_id).to eq(101)
#     end

#     it "has a user id" do
#       @testchatsuser2 = ChatsUser.create!(user_id:100)
#       expect(@testchatsuser2.user_id).to eq(100)
#     end

#   end
# end