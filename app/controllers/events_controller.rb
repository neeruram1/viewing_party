require "google/api_client/client_secrets.rb"
require "google/apis/calendar_v3"

class EventsController < ApplicationController
  def create
    @user = User.find(current_user.id)
    @party = ViewParty.find(params[:party_id])
    @calendar = create_event
    redirect_to '/dashboard'
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
    binding.pry
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_secret.to_authorization
    service.authorization.refresh!

    event1 = Google::Apis::CalendarV3::Event.new({
    'summary':"#{party.movie.name}",
    'location':'Our living rooms!',
    'description':'Viewing Party time!',
    'start':{
      'date_time': party.date,
      'time_zone': 'America/Los_Angeles'
    },
    'end':{
      'date_time': DateTime.parse('2016-05-28T17:00:00-07:00'),
      'time_zone': 'America/Los_Angeles'
    }
  })

    service.insert_event('primary', event)
  end
end
