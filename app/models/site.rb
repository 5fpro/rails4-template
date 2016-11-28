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

  store_accessor :data, :tmp

  before_validation :generate_subdomain

  def to_api
    {
      status: 200,
      site: {
        name: self.name,
        subdomain: self.subdomain,
        host: self.host
      }
    }
     
  end

  def error_message
    error_message = {
      status: 400,
      error_message: self.errors
    }
  end

  private

  def generate_subdomain
    name = SecureRandom.uuid.to_s[0, 5]
    while Site.where(subdomain: name).count > 0
      name = SecureRandom.uuid.to_s[0, 5]
    end
    self.subdomain = name
  end
end
