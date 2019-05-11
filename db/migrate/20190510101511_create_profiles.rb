class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references  :user,       foreign_key: true
      t.integer     :job
      t.integer     :birthplace
      t.integer     :residence
      t.integer     :blood
      t.integer     :annual_income
      t.timestamps
    end
  end
end
