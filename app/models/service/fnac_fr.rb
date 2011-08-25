class Service::FnacFr < Service::Base
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
    "la Fnac"
  end

  protected
    def perform_query(query)
      page = Nokogiri::HTML(open("http://recherche.fnac.com/Search/SearchResult.aspx?Search=#{query}&ItemPerPage=50"))
      page.css('.prd-result').first.css('.oneprd').map do |prd|
        title = prd.css('.lienInverse.title').first.content.strip
        url = prd.css('.lienInverse.title').first.css('a').first['href']
        details = prd.css('.lienInverse.details').first.content.strip
        price = prd.css('.prix.smallPrice').first.content.strip
        details =~ /Tablette tactile/ ? {title: title, url: url, price: price[/\d+(,\d+)?/]} : nil
      end
    end
end