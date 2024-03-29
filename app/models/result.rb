class Result
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :avert

  belongs_to :service, :class_name => 'Service::Base', :inverse_of => :results
  has_and_belongs_to_many :averted_by_email_registrations, :class_name => 'Registration', :inverse_of => :received_by_email_results

  field :title
  field :url
  field :price, :type => Float
  field :other

  validates :title, :uniqueness => { :scope => :service_id }
  validate :hp_touchpad?

  def hp_touchpad?
    errors[:hp_touchpad?] << "This result is not an HP TouchPad" unless service.class.hp_touchpad?(self)
    (errors[:confirmed] << "Not confirmed" unless service.class.confirm(self.url)) rescue puts "ERROR: Confirmation #{url}"
  end

  def avert
    avert_by_email
  end

  def avert_by_email
    Registration.confirmed.each do |registration|
      ResultMailer.avert(registration, self).deliver
    end
  end
end
