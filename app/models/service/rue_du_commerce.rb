class Service::RueDuCommerce < Service::Base
  include Mongoid::Document

  def results(options={})
    results = queries.map do |query|
      perform_query query
    end
    results.flatten
    results.delete nil
    results
  end

  def full_name
    "rue du commerce"
  end

  protected
    def perform_query(options={})
      page = Nokogiri::HTML(open("http://search.rueducommerce.fr/search?s=#{query}"))
      page.css('.blcResRech').first.css('.prdDiv').map do |prd|
        title = prd.css('.prdTitle').first.content.strip
        url = prd.css('.prdTitle').first.css('a').first['href']
        rayons = prd.css('.prdDescrAr').first.content.strip
        price = prd.css('.price1x').first.content.strip
        rayons =~ /Tablette et iPad/ ? {title: title, url: url, price: price[/\d+(,\d+)?/]} : nil
      end
    end
end