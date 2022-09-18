class Event < ApplicationRecord
  # где спектакль еще не кончился на текущий момент в порядке от начала...
  scope :actual, -> { where('upper(schedule) >= ?', Date.today).order('lower(schedule)') }

  attribute :starts_at, :date
  attribute :ends_at, :date

  before_validation :set_schedule

  validates :title, presence: true
  validates :starts_at, :ends_at, presence: true, on: :create
  # проверка валидности дат
  validate :check_dates_order
  validate :check_schedule_overlapping

  private

  def check_dates_order
    return unless starts_at.present? && ends_at.present?

    errors.add(:ends_at, 'must be after starts_at') if ends_at < starts_at
  end

  # проверка на уровне рельс (не БД), есть ли в БД спектакли с пересечением дат
  def check_schedule_overlapping
    return unless schedule.present?

    # Если спектакль уже записан в базу, то его не нужно учитывать
    scope = persisted? ? Event.where.not(id: id) : Event.all
    return unless scope.where('? >= lower(schedule) AND upper(schedule) >= ?', schedule.end, schedule.begin).exists?

    # ошибка, если есть пересечения
    errors.add(:starts_at, :taken)
    errors.add(:ends_at, :taken)
  end

  def set_schedule
    return unless starts_at.present? && ends_at.present?

    self.schedule = starts_at..ends_at
  end
end

# <---> - спектакль, который пытаемся создать
# [---] - уже существующий

# [ - starts_at
# ] - ends_at
# < - new_starts_at
# > - new_ends_at

# 1. <------>  [------] - не пересекаются
# 2. [------]  <------> - не пересекаются
# 3. <---[-->---] - пересекаются
# 4. [----<--]----> - пересекаются
# 5. <----[---]---> - пересекаются
# 6. [----<--->---] - пересекаются

# Не конфликтуют тогда и только тогда, когда:
# - starts_at > new_ends_at OR new_starts_at > ends_at

# Т.е. конфликтует тогда и только тогда, когда:
# - NOT(starts_at > new_ends_at OR new_starts_at > ends_at)
# иначе говоря:
# - NOT(starts_at > new_ends_at) AND NOT(new_starts_at > ends_at)
# иначе говоря:
# - starts_at <= new_ends_at AND new_starts_at <= ends_at

# Пример:
# NOT(x > 3 OR x < 1)
# равносильно
# NOT(x > 3) AND NOT(x < 1)
# равносильно:
# Перевернем отрицание:
# x <= 3 AND x >= 1
