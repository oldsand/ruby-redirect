class AddCountToLink < ActiveRecord::Migration
  def change
    add_column :links, :count, :integer, default: 0
  end
end
