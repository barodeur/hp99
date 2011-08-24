class Service::FnacFr < Service::Base
  include Mongoid::Document

  def self.results(options={})
    options[:query] ||= 'hp+touchpad'
    page = Nokogiri::HTML(open("http://recherche.fnac.com/Search/SearchResult.aspx?Search=#{options[:query]}&ItemPerPage=50"))
    results = page.css('.prd-result').first.css('.oneprd').map do |prd|
      title = prd.css('.lienInverse.title').first.content.strip
      url = prd.css('.lienInverse.title').first.css('a').first['href']
      details = prd.css('.lienInverse.details').first.content.strip
      price = prd.css('.prix.smallPrice').first.content.strip
      details =~ /Tablette tactile/ ? {title: title, url: url, price: price[/\d+(,\d+)?/]} : nil
    end
    results.delete nil
    results
  end
end