class RemoveViewPartyFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :view_party_id, :bigint
  end
end
