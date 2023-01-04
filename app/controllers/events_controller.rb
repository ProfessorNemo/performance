# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    events = Event.actual

    render json: events
  end

  def create
    event = Event.new(event_params)

    event.save

    respond_with(event)
  end

  def destroy
    event = Event.find(params[:id])

    event.destroy

    render json: { success: :ok }
  end

  private

  def event_params
    params.require(:event).permit(:title, :starts_at, :ends_at)
  end
end

# возвращаем json, ибо у нас API
