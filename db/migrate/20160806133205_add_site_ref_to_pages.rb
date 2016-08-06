class AddSiteRefToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :site, index: true, foreign_key: true
  end
end
