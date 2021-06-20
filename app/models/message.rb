class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :message, {length: {in: 1..200} }
end
