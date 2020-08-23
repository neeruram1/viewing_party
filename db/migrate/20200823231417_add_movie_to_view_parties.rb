class AddMovieToViewParties < ActiveRecord::Migration[5.2]
  def change
    add_reference :view_parties, :movie, foreign_key: true
  end
end
