class Result
  include Mongoid::Document

  after_create :avert

  belongs_to :service, :class_name => 'Service::Base'
  has_and_belongs_to_many :averted_by_email_registrations, :class_name => 'Registration', :inverse_of => :received_by_email_results

  field :title
  field :url
  field :price, :type => Float

  validates :title, :uniqueness => { :scope => :service_id }

  def avert
    avert_by_email
  end

  def avert_by_email
    Registration.not_in(:id => self.averted_by_email_registration_ids).each do |registration|
      ResultMailer.avert(registration, self).deliver
    end
  end
end
