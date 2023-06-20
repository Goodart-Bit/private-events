class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build event_params
    if @event.save
      redirect_to @event, notice: 'Event created successfully'
    else
      render new_event_path(@event), alert: 'Something went wrong'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    Event.delete(params[:id])
    redirect_to users_show_path, notice: "Event #{params[:id]} deleted successfully"
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    if event.update event_params
      redirect_to event, notice: 'Event edited successfully'
    else
      render edit_event_path(event), alert: 'Could not update event'
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
