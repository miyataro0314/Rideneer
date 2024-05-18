class SearchesController < ApplicationController
  def new
    clear_session
    @search_spots_form = SearchSpotsForm.new
  end

  def search_spots_modal
    @search_spots_form = SearchSpotsForm.new(session_spots_params)
  end

  def search_spots
    set_page
    set_spot_search_query
    search_spots_form = SearchSpotsForm.new(session_spots_params)
    @spots = search_spots_form.search.page(session[:page])
    render 'spots/index'
  end

  private

  def search_spots_params
    params.require(:search_spots_form).permit(%i[area category parking]) if params[:search_spots_form]
  end

  def clear_session
    keys = %i[page area category parking]
    keys.each { |key| session.delete(key) }
  end

  def set_page
    session[:page] = params[:page] if params[:page]
  end

  def set_spot_search_query
    return unless params[:search_spots_form]

    session[:area] = search_spots_params[:area]
    session[:category] = search_spots_params[:category]
    session[:parking] = search_spots_params[:parking]
  end

  def session_spots_params
    {
      area: session[:area],
      category: session[:category],
      parking: session[:parking]
    }
  end
end
