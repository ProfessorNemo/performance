# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  # аттрибуты, которые надо возвращать
  attributes :id, :title, :start_date, :end_date

  def start_date
    object.schedule.begin.strftime('%d-%m-%Y')
  end

  def end_date
    object.schedule.end.strftime('%d-%m-%Y')
  end
end
