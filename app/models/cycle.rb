class Cycle < ApplicationRecord
  validates_presence_of :name
  has_many :invitations
end
