class Service::Cdiscount < Service::Base
  include Mongoid::Document

  def full_name
    "Cdiscount"
  end

  def self.hp_touchpad?(result)
    result.other =~ /^Tablette/
  end

  def self.confirm(url)
    page = Nokogiri::HTML(open(url))
    price = page.css('.ps-ttcprice .nodisp').try(:first).try(:content).try(:strip)
    add_to_basket_link = page.css('.ps-addtobasketbutton').first
    availability = page.css('.ps-shippingstatustop').try(:first).try(:content).try(:strip)
    price =~ /\d+(,\+)?/ && availability =~ /en stock/i && add_to_basket_link.present?
  end

  protected
    def self.perform_query(query)
      page = Nokogiri::HTML(open("http://www.cdiscount.com/sa-10/#{query}.html"))
      page.css('.background100Std001 .productList100Std001').map do |prd|
        title = prd.css('.productTitle').first.content.strip
        url = prd.css('.productTitle').first['href']
        description = prd.css('.productShortDesc').first.try(:content).try(:strip)
        price = prd.css('.productPriceTtc .nodisp').first.content.strip
        instance.results.create({title: title, url: url, price: price[/\d+(,\d+)?/], other: description})
      end
    end
end