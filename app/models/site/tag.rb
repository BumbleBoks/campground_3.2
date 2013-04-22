class Site::Tag < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, presence: true,                
            format: { with: /^[\w]+$/ },
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false }
end
