class AddColumnSiteIdToPages < ActiveRecord::Migration
  def change

    add_column :pages, :site_id, :integer
    add_index :pages, :site_id
  end
end
