class Fitness < ActiveRecord::Base
mount_uploader :imagen, FotoUploader
belongs_to :user
has_and_belongs_to_many :fitnesses_users, :foreign_key => 'fitness_id', :class_name => "User"

default_scope {order("punctuation DESC")}
scope :favoritos,->(term=nil) {term==='nil'? all : joins(:fitnesses_users).where("fitnesses_users.user_id = ?", "#{term}") }

def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end
end
