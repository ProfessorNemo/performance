class AddScheduleOvelappingConstraint < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL
      ALTER TABLE events
      ADD CONSTRAINT check_schedule_overlapping
      EXCLUDE USING gist (schedule WITH &&)
    SQL
  end

  def self.down
    execute 'ALTER TABLE events DROP CONSTRAINT check_schedule_overlapping'
  end
end
