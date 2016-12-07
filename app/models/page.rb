# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  slug       :string
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
	validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

	belongs_to :site

	def to_param
    slug
  end
end
