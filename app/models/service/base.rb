class Service::Base
  include Mongoid::Document

  has_and_belongs_to_many :queries

  validates :_type, :uniqueness => true

  def self.results
    fail
  end
end
