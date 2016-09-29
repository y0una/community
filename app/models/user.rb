require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  has_and_belongs_to_many :chats

  include BCrypt
  validates :user_name, :email, presence: true
  validates :email, uniqueness: true

  #getter
  def password
    @password ||= Password.new(password_hash)
  end

  #setter
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, input_password)
    @user = User.find_by(email: email)
    p "***************** user: *****************"
    p @user

    p "password:"
    p @user.password

    p "input password:"
    p input_password

    # if find user && input password == password return that user
      if @user && @user.password == input_password
        return @user
      # otherwise, return nil
      else
        nil
      end
  end

end
