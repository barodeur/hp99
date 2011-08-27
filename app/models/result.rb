class Result
  include Mongoid::Document

  after_create :avert

  belongs_to :service, :class_name => 'Service::Base', :inverse_of => :results
  has_and_belongs_to_many :averted_by_email_registrations, :class_name => 'Registration', :inverse_of => :received_by_email_results

  field :title
  field :url
  field :price, :type => Float
  field :other

  validates :title, :uniqueness => { :scope => :service_id }

  validate do |result|
    result.errors[:hp_touchpad] << "This result is not an HP TouchPad" unless result.hp_touchpad?
  end

  def avert
    avert_by_email
  end

  def avert_by_email
    Registration.where(:confirmed_at.ne => nil).each do |registration|
      ResultMailer.avert(registration, self).deliver
    end
  end

  def hp_touchpad?
    service.class.hp_touchpad?(self) && service.class.confirm(self.url)
  end
end
