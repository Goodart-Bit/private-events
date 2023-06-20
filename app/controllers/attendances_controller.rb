class AttendancesController < ApplicationController

  def index
  end

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    event = Event.find(params[:event_id])
    guests_ids = attendance_params[:guest_ids]
    non_persisted = persisted_attendances(event.id, guests_ids) - guests_ids
    if non_persisted.any?
      render attendances_path(event_id),
             alert: "System could not invite users #{non_persisted}"
    else
      redirect_to event, notice: 'Invitations were sent successfully'
    end
  end

  def destroy
    begin
      p params[:id]
      Attendance.destroy(params[:id])
      redirect_to users_show_path, notice: 'Your assistance was removed successfully'
    rescue ActiveRecord::RecordNotFound => e
      redirect_to users_show_path, alert: 'An error occurred during the deletion of this assistance'
    end
  end

  private

  def persisted_attendances(event_id, guests_ids)
    guests_ids.reduce(Array.new) do |persisted_ids, attendee_id|
      persisted_ids << attendee_id if
        Attendance.create attendee_id:, event_id: event_id
      persisted_ids
    end
  end

  def attendance_params
    permit_params = params.require(:attendance).permit(:guest_ids => [])
    sanitize_params permit_params
    permit_params
  end

  def sanitize_params(permit_params) # CHECKBOX returns empty values on unchecked
    permit_params[:guest_ids].filter! { |id| !id.empty? }
  end
end
