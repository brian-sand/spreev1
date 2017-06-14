Spree::SupplierAbility.class_eval do
    def initialize(user)
      user ||= Spree.user_class.new

      if user.supplier
        # TODO: Want this to be inline like:
        # can [:admin, :read, :stock], Spree::Product, suppliers: { id: user.supplier_id }
        # can [:admin, :read, :stock], Spree::Product, supplier_ids: user.supplier_id
        can [:admin, :read, :stock, :modify, :update], Spree::Product do |product|
          product.supplier_ids.include?(user.supplier_id)
        end
        can [:admin, :index, :create ], Spree::Product
        can [:update], BigDecimal
	can [:modify], Spree::Classification
	can [:modify], Spree::ProductOptionType 
        can [:admin, :index, :modify], Spree::Image
        can [:admin, :modify], Spree::Variant
        can [:admin, :update], Spree::ProductProperty
        can [:all], Spree::Price
        can [:admin], Spree::Stock
        can [:admin, :show], Spree::Prototype
        can [:admin, :manage, :read, :ready, :ship], Spree::Shipment, order: { state: 'complete' }, stock_location: { supplier_id: user.supplier_id }
        can [:admin, :create, :update], :stock_items
        can [:admin, :manage], Spree::StockItem, stock_location_id: user.supplier.stock_locations.pluck(:id)
        can [:admin, :manage], Spree::StockLocation, supplier_id: user.supplier_id
        can :create, Spree::StockLocation
        can [:admin, :manage], Spree::StockMovement, stock_item: { stock_location_id: user.supplier.stock_locations.pluck(:id) }
        can :create, Spree::StockMovement
        can [:admin, :update], Spree::Supplier, id: user.supplier_id
      end
    end
end

