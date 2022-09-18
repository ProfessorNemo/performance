class EventsController < ApplicationController
  def index
    events = Event.all

    render json: events
  end

  def create
    event = Event.new(event_params)

    if event.save
      render json: event
    else
      render json: { errors: event.errors.full_messages }, status: 422
    end
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
