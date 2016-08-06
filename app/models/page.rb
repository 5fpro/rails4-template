class Page < ActiveRecord::Base

  validates_presence_of :slug
  belongs_to :site
end
