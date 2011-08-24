require 'open-uri'

module Service
  class RueDuCommerce < Base
    def self.results(options={})
      options[:query] ||= 'hp+touchpad'
      page = Nokogiri::HTML(open("http://search.rueducommerce.fr/search?s=#{options[:query]}"))
      results = page.css('.blcResRech').first.css('.prdDiv').map do |prd|
        title = prd.css('.prdTitle').first.content.strip
        url = prd.css('.prdTitle').first.css('a').first['href']
        rayons = prd.css('.prdDescrAr').first.content.strip
        price = prd.css('.price1x').first.content.strip
        rayons =~ /Tablette et iPad/ ? {title: title, url: url, price: price[/\d+(,\d+)?/]} : nil
      end
      results.delete nil
      results
    end
  end
end