class VenuesController < ApplicationController
  def index
    @venues = Venue.all

    @markers = @venues.geocoded.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        info_window: render_to_string(partial: "info_window", locals: { venue: venue } )
      }
    end
  end

  def show
    @venue = Venue.find(params[:id])
    @booking = Booking.new
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)

    @venue.save
    redirect_to venues_path(@venues)

  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    @venue.update(params)

    redirect_to my_venues_path
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    redirect_to my_venues_path
  end

  def map
    @venues = Venue.all

    @markers = @venues.geocoded.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        info_window: render_to_string(partial: "info_window", locals: { venue: venue } )
      }
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:title, :location, :description, :rate, :square_meters, :image_url)
  end

end
