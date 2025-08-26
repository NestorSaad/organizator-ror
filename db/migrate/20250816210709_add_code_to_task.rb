class AddCodeToTask < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :code, :string
  end
end
