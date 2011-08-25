class Service::Base
  include Mongoid::Document

  has_many :results, :inverse_of => :service
  has_and_belongs_to_many :queries

  validates :_type, :uniqueness => true

  def full_name
    fail
  end

  def self.hp_touchpad?(result)
    fail
  end

  def self.fetch_results(options={})
    fail if self == Service::Base
    instance.queries.each do |query|
      perform_query query
    end
  end

  def self.instance
    fail if self == Service::Base
    self.first
  end

  def self.instances
    all
  end

  protected
    def self.perform_query(query)
      fail
    end
end
