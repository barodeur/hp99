class Registration
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :received_by_email_results, :class_name => 'Result', :inverse_of => :averted_by_email_registrations

  field :email

  validates :email, presence: true, :uniqueness => true
end
