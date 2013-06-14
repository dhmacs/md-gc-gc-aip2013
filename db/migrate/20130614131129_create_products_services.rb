class CreateProductsServices < ActiveRecord::Migration
  def change
    create_table :products_services do |t|
      t.references :product, :null => false
      t.references :service, :null => false
    end
  end
end
