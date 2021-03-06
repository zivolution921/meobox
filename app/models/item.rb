class Item < ActiveRecord::Base
  belongs_to :box
  validates :title, :description, :size, presence: true
  validates :description, length: { minimum: 5 }
  do_not_validate_attachment_file_type :image

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, default_url: "/images/missing.jpeg"

  paginates_per 5
 
  def self.search(search_key_word)
    if search_key_word.present? && !search_key_word.nil?
       where(["title LIKE ?","%#{search_key_word}%"])
    else
      all
    end
  end
end
