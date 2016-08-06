# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :integer
#
# Foreign Keys
#
#  fk_rails_a8ad97ecff  (site_id => sites.id)
#

class Page < ActiveRecord::Base
  belongs_to :site

  validates :slug, :uniqueness => true, :presence => true

end
