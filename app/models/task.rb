class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'

  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  validates_presence_of :name, :description, :participating_users
  validates_uniqueness_of :name, case_insensitive: false

  validate :due_date_validity

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end
end
