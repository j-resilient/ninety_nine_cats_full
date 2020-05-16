class RemoveUniquenessIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :cats, :name
  end
end
