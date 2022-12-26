class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :options, through: :questions

  validates_presence_of :name

  accepts_nested_attributes_for :questions, reject_if: :all_blank
  accepts_nested_attributes_for :options, reject_if: :all_blank

  validates_associated :questions, :options
end
