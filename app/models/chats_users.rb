class ChatsUser < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :chat
  belongs_to :user
end
