class CreateWeathers < ActiveRecord::Migration[5.1]
  def change
    create_table :weathers do |t|
      t.string :location_name
      t.decimal :lat
      t.decimal :lng
      t.string :current_weather
      t.string :two_day_hourly_weather
      t.string :week_daily_weather

      t.timestamps
    end
  end
end
