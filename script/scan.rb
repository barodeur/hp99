puts '# NEW SCAN #'
puts "#{Time.now}"
results = [Service::FnacFr, Service::RueDuCommerce, Service::Cdiscount].map do |service_class|
  puts "Fetching #{service_class}"
  service_class.fetch_results
end
