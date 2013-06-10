class CreateCfwdRegs < ActiveRecord::Migration
  def change
    create_table :cfwd_regs do |t|
      t.string :mobile
      t.string :cf_type
      t.integer :user_id
      t.date :c_date

      t.timestamps
    end
  end
end
