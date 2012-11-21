class AddColumnToJfName < ActiveRecord::Migration
  def change
    add_column :jf_names, :p_nat, :string
    add_column :jf_names, :p_local, :string
    add_column :jf_names, :p_suburban, :string
    add_column :jf_names, :p_int, :string
    add_column :jf_names, :p_emerg, :string
  end
end
