class Video < ActiveRecord::Base
  belongs_to :post

  validates :slug, :presence => true, :uniqueness => true, :format => { :with => /^(\w|-){11}$/, :message => 'is invalid.  Use 11 letters, numbers, or underscores' }
  validates :title, :presence => true, :length => { :in => 4..30, :message => 'is too long or too short' }

end
