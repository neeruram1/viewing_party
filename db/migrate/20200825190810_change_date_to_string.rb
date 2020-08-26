class ChangeDateToString < ActiveRecord::Migration[5.2]
  def change
    change_column :view_parties, :date, :string
  end
end
