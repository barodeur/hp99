puts '######################'
puts 'NEW SCAN'
Service::FnacFr.fetch_results
Service::RueDuCommerce.fetch_results
