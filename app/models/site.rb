# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  host       :string
#  subdomain  :string
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base

  validates :subdomain, presence: true, uniqueness: true
  validates :host, uniqueness: true, allow_nil: true
  validates :name, presence: true



  def api_info
    return {
      name: self.name,
      host: self.host,
      subdomain: self.subdomain
    }
  end

end
