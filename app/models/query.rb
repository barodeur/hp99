class Query
  include Mongoid::Document

  field :keywords, :type => Array

  def keywords=(keywords)
    write_attribute :keywords, keywords.strip.split(/\s/)
  end

  def keywords
    read_attribute :keywords
  end
end
