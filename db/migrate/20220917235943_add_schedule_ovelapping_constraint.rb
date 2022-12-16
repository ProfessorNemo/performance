# frozen_string_literal: true

class AddScheduleOvelappingConstraint < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      ALTER TABLE events
      ADD CONSTRAINT check_schedule_overlapping
      EXCLUDE USING gist (schedule WITH &&)
    SQL
  end

  def self.down
    execute 'ALTER TABLE events DROP CONSTRAINT check_schedule_overlapping'
  end
end

# Добавим ограничение ввиду возможного пересечения расписания спектаклей,
# чтобы в БД не попали кривые данные
