class HomesController < ApplicationController
  before_action :require_profile, only: :my_page

  def home
    set_latest_spots
    set_spot_by_access_history
    set_query_by_search_history
    set_weather_data
  end

  def weather_detail
    set_weather_data
  end

  def my_page
    @profile = current_user.profile
  end

  def my_spots
    @selected_tab = params[:tab] || 'bookmark'
    @registered_spots = current_user.spots.order(created_at: :desc).page(params[:page_register])
    @bookmarked_spots = current_user.bookmarked_spots.order(created_at: :desc).page(params[:page_bookmark])
  end

  def account
    utc_time = current_user.created_at
    local_time = utc_time.in_time_zone(Rails.application.config.time_zone)
    @registration_date = local_time.strftime('%Y年%m月%d日')
  end

  def cancellation; end

  private

  def require_profile
    return if current_user.profile

    redirect_to new_profile_path, alert: 'プロフィールの登録をお願いします'
  end

  def set_latest_spots
    @spots = Spot.includes(:spot_detail).order(created_at: :desc).limit(5)
  end

  def set_weather_data
    response = HTTP.get('https://weather.tsukumijima.net/api/forecast/city/130010')
    @data = JSON.parse(response.body)
    forecasts = @data['forecasts']

    @first = forecasts[0]
    @second = forecasts[1]
    @third = forecasts[2]
  end

  def set_spot_by_access_history
    @last_access_spot = current_user.access_histories.last&.spot
    @last_access_spot_detail = @last_access_spot.spot_detail unless @last_access_spot.nil?
  end

  def set_query_by_search_history
    @last_search_query = current_user.search_histories.last
    return unless @last_search_query

    session[:area] = @last_search_query.area
    session[:category] = @last_search_query.category
    session[:parking] = @last_search_query.parking
  end
end
