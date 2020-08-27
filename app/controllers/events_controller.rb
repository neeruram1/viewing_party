require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class EventsController < ApplicationController
  def create
    @user = User.find(current_user.id)
    @party = ViewParty.find(params[:party_id])

    event = CalendarService.new.create_event(@user, @party)

    if event.status == 'confirmed'
      redirect_to '/dashboard'
      flash[:message] = 'Viewing Party has been added to your Google Calendar!'
    else
      redirect_to '/dashboard'
      flash[:message] = 'Oops! Something must have gone wrong.'
    end
  end
end
