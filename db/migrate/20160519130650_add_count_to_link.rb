class AddCountToLink < ActiveRecord::Migration
  def change
    add_column :links, :type, :integer
  end
end
