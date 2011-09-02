class Registration
  include Mongoid::Document
  include Mongoid::Timestamps

  before_create :generate_confirmation_token
  after_create :send_confirmation_token

  has_and_belongs_to_many :received_by_email_results, :class_name => 'Result', :inverse_of => :averted_by_email_registrations

  field :email
  field :confirmation_token
  field :confirmed_at, :type => DateTime
  attr_accessible :email

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def confirm!
    update_attribute :confirmed_at, DateTime.now
  end

  protected
    def generate_confirmation_token
      self.confirmation_token = SecureRandom.hex(16)
    end

    def send_confirmation_token
      RegistrationMailer.confirmation(self).deliver
    end
end
