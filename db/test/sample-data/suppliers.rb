
role_user = Spree::Role.where(name: "user").first

ralph_user = Spree::User.where(email: "ralph@ralph.com").first_or_create! do | u |
  u.password = "spree123"
end
ralph_user.role_users.create!(role: role_user)

ab_user = Spree::User.where(email: "abercrombie@ab.com").first_or_create! do | u |
  u.password = "spree123"
end
ab_user.role_users.create!(role: role_user)

ut_user = Spree::User.where(email: "untuckit@ut.com").first_or_create! do | u |
  u.password = "spree123"
end
ut_user.role_users.create!(role: role_user)

Spree::Supplier.where(email: "ralph@ralph.com").first_or_create! do |supplier|
  supplier.name = "Ralph Lauren"
  supplier.active = true
  supplier.users << ralph_user
end

Spree::Supplier.where(email: "abercrombie@ab.com").first_or_create! do |supplier|
  supplier.name = "Abercrombie"
  supplier.active = true
  supplier.users << ab_user
end

Spree::Supplier.where(email: "untuckit@ut.com").first_or_create! do |supplier|
  supplier.name = "Untuckit"
  supplier.active = true
  supplier.users << ab_user
end