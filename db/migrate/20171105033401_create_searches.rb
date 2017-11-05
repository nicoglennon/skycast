class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|

      #attributes
      t.string :location_name
      t.decimal :lat
      t.decimal :lng

      #associations
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
