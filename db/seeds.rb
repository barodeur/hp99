# Q U E R I E S
hp_touchpad = Query.create :keywords => 'hp touchpad'

# S E R V I C E S
fnac_fr = Service::FnacFr.create :queries => [hp_touchpad]
rue_du_commerce = Service::RueDuCommerce.create :queries => [hp_touchpad]
