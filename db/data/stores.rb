# Possibly already created by a migration.
unless Spree::Store.where(code: 'premium').exists?
  Spree::Store.new do |s|
    s.code              = 'premium'
    s.name              = 'Premium Factory Outlet'
    s.url               = 'premium.com'
    s.mail_from_address = 'admin@premium.com'
  end.save!
end