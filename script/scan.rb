puts '# NEW SCAN #'
puts "#{Time.now}"
Service::FnacFr.fetch_results
Service::RueDuCommerce.fetch_results
Service::Cdiscount.fetch_results
