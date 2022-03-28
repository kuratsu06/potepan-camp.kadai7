class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, optional: true
  
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :person, numericality: true
  validates :user_id, presence: true
  validates :room_id, presence: true
  
  validate :day_before_start
  validate :day_before_end

  def day_before_start
    return if start_at.blank?
    errors.add("過去の日付は無効です") if start_at < Date.today
  end

  def day_before_end
    return if end_at.blank? || start_at.blank?
    errors.add("終了日は開始日より後にしてください") if end_at < start_at
  end
end