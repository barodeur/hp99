class Registration
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email

  validates :email, presence: true, :uniqueness => true
end
