require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class CalendarService
  def google_secret(user)
    Google::APIClient::ClientSecrets.new(
      { 'web' => { 'access_token' => user.access_token,
                   'refresh_token' => user.refresh_token,
                   'client_id' => ENV['GOOGLE_CLIENT_ID'],
                   'client_secret' => ENV['GOOGLE_CLIENT_SECRET'] } }
    )
  end

  def create_event(user, party)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_secret(user).to_authorization
    service.authorization.refresh!

    event = Google::Apis::CalendarV3::Event.new(
      summary: "A #{party.movie.name} Viewing Party!",
      description: "Let's watch a movie together!",
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date: party.date.to_s
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date: party.date.to_s
      )
    )
    service.insert_event('primary', event)
  end
end
