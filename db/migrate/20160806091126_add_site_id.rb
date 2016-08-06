class AddSiteId < ActiveRecord::Migration
  def change
    add_column :pages, :site_id, :integer, :index => true
  end
end
