class Background < ActiveRecord::Base
  belongs_to :post

  validates :author, :presence => true
  validates :author_link, :presence => true #, :format => { :with => /^http:\/\/www.flickr.com\/photos\/\w+\/$/ }
  validates :flickr, :presence => true #, :format => { :with => /^http:\/\/www.flickr.com\/photos\/\w+\/\d{8,11}/ }
  validates :naked, :presence => true #, :format => { :with => /^http:\/\/farm\d.staticflickr.com\// }
  validates :cc_type, :presence => true, :numericality => { :only_integer => true }

  DEFAULT = Background.new(Hash[:author => 'Dave Morrow', :flickr => 'http://www.flickr.com/photos/daves-f-stop/6803701386/', :naked => 'http://farm8.staticflickr.com/7200/6803701386_82682c2277_b.jpg', :author_link => 'http://www.flickr.com/people/daves-f-stop/', :cc_type => 5])

  def cc_link
    type = get_cc_string
    'http://creativecommons.org/licenses/' + type + '/3.0/'
  end
  
  def cc_logo
    type = get_cc_string
    'http://i.creativecommons.org/l/' + type + '/3.0/88x31.png'
  end

  def get_cc_string
    cc_string = case self.cc_type
    when 1 then 'by'
    when 2 then 'by-sa'
    when 3 then 'by-nd'
    when 4 then 'by-nc'
    when 5 then 'by-nc-sa'
    when 6 then 'by-nc-nd'
    end
  end

end
