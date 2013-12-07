class LodgesController < ApplicationController
  before_action :set_lodge, only: [:show, :edit, :update, :destroy]

  def index
    search = params[:search]
    @lodges = Lodge.all_filter_by_name(search)
    unless search.blank?
      @search_message = 'Results for: '+search
    end
  end

  def show
  end

  def new
    @lodge = Lodge.new
  end

  def edit
  end

  def create
    @lodge = Lodge.new(lodge_params)

    respond_to do |format|
      if @lodge.save
        format.html { redirect_to @lodge, notice: 'Lodge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lodge }
      else
        format.html { render action: 'new' }
        format.json { render json: @lodge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lodge.update(lodge_params)
        format.html { redirect_to @lodge, notice: 'Lodge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lodge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lodge.destroy
    respond_to do |format|
      format.html { redirect_to lodges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lodge
      @lodge = Lodge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lodge_params
      params.require(:lodge).permit(:name, :lat, :long, :category, :image, :address)
    end
end
