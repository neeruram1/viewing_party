require "google/api_client/client_secrets.rb"
require "google/apis/calendar_v3"

class EventsController < ApplicationController
  def create
    @user = User.find(current_user.id)
    @party = ViewParty.find(params[:party_id])

    @event = create_event

    if event.status == 'confirmed'
      redirect_to '/dashboard'
      flash[:message] = 'Viewing Party has been added to your Google Calendar!'
    else
      redirect_to '/dashboard'
      flash[:message] = 'Oops! Something must have gone wrong.'
    end
  end

  private

  def google_secret
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => @user.access_token,
          "refresh_token" => @user.refresh_token,
          "client_id" => ENV['GOOGLE_CLIENT_ID'],
          "client_secret" => ENV['GOOGLE_CLIENT_SECRET']
        }
      }
    )
  end

  def calendar_service
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_secret.to_authorization
    service.authorization.refresh!
  end

  def create_event
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_secret.to_authorization
    service.authorization.refresh!

    event = Google::Apis::CalendarV3::Event.new(
      summary: "A #{@party.movie.name} Viewing Party!",
      description: "Let's watch a movie together!",
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date: "#{@party.date}",
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date: "#{@party.date}",
      ),
    )
    service.insert_event('primary', event)
  end
end
