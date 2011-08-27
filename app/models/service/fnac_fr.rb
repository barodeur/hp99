class Service::FnacFr < Service::Base
  include Mongoid::Document

  def full_name
    "la Fnac"
  end

  def self.hp_touchpad?(result)
    result.other =~ /Tablette tactile/
  end

  def self.confirm(url)
    page = Nokogiri::HTML(open(url))
    price = page.css('.price').try(:first).try(:content).try(:strip)
    availability = page.css('.moutarde').first.content.strip
    price =~ /\d+(,\+)?/ && availability =~ /en stock/i
  end

  protected
    def self.perform_query(query)
      page = Nokogiri::HTML(open("http://recherche.fnac.com/Search/SearchResult.aspx?Search=#{query}&ItemPerPage=50"))
      page.css('.prd-result').first.css('.oneprd').map do |prd|
        title = prd.css('.lienInverse.title').first.content.strip
        url = prd.css('.lienInverse.title').first.css('a').first['href']
        details = prd.css('.lienInverse.details').first.content.strip
        price = prd.css('.prix.smallPrice').first.content.strip
        instance.results.create({title: title, url: url, price: price[/\d+(,\d+)?/], other: details})
      end
    end
end