class Diet < ActiveRecord::Base
mount_uploader :imagen, ImageUploader
belongs_to :user
has_and_belongs_to_many :diets_users, :foreign_key => 'diet_id', :class_name => "User"

default_scope {order("punctuation DESC")}
scope :favoritos,->(term=nil) {term==='nil'? all : joins(:diets_users).where("diets_users.user_id = ?", "#{term}") }
def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end
end
