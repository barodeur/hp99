class Service::Base
  include Mongoid::Document

  has_and_belongs_to_many :queries

  validates :_type, :uniqueness => true

  def results
    fail
  end

  def self.instance
    fail if self == Service::Base
    self.first
  end
end
