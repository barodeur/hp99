class Service::RueDuCommerce < Service::Base
  include Mongoid::Document

  def full_name
    "rue du commerce"
  end

  def self.hp_touchpad?(result)
    result.other =~ /Tablette et iPad/
  end

  def self.confirm(url)
    page = Nokogiri::HTML(open(url))
    price = page.css('.fpPriceBig').try(:first).try(:content).try(:strip)
    add_to_basket_link_title = page.css('.buy.fright a').try(:first).try(:[], 'title')
    price =~ /\d+(,\+)?/ && add_to_basket_link_title =~ /Ajoutez ce produit dans votre panier/
  end

  protected
    def self.perform_query(query)
      page = Nokogiri::HTML(open("http://search.rueducommerce.fr/search?s=#{query}"))
      page.css('.blcResRech').first.css('.prdDiv').map do |prd|
        title = prd.css('.prdTitle').first.content.strip
        url = prd.css('.prdTitle').first.css('a').first['href']
        rayons = prd.css('.prdDescrAr').first.content.strip
        price = prd.css('.price1x').first.content.strip
        instance.results.create({title: title, url: url, price: price[/\d+(,\d+)?/], other: rayons})
      end
    end
end