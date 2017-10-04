class MyEventsController < ApplicationController
  before_action :set_my_event, only: [:show, :update, :destroy]

  # GET /my_events
  def index
    @my_events = MyEvent.all

    render json: @my_events
  end

  # GET /my_events/1
  def show
    render json: @my_event
  end

  # POST /my_events
  def create
    @my_event = MyEvent.new(my_event_params)

    if @my_event.save
      render json: @my_event, status: :created, location: @my_event
    else
      render json: @my_event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /my_events/1
  def update
    if @my_event.update(my_event_params)
      render json: @my_event
    else
      render json: @my_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /my_events/1
  def destroy
    @my_event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_event
      @my_event = MyEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def my_event_params
      params.require(:my_event).permit(:event_type, :remote_ip,
        :referer => [:scheme, :host, :path, :query, :fragment])
    end
end
