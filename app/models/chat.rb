class Chat < ApplicationRecord
  validates :chat, presence: true
  belongs_to :user
  belongs_to :chat_room
end
