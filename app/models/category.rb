class Category < ApplicationRecord
  has_many :tasks

  validates_presence_of :name, :description
  validates_uniqueness_of :name,  case_insensitive: false
end
