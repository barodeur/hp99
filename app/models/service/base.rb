class Service::Base
  include Mongoid::Document

  field :queries, :type => Array

  validates :_type, :uniqueness => true

  def self.results
    fail
  end
end
