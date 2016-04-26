class PlaceparkingController < ApplicationController
  def index
    @listeplaces = Placeparking.all
  end
  
  def show
    @placeparking = Placeparking.find(params[:id])
  end

  def edit
  end

  def update
    historique = Historique.new(occupied: params[:occupied])
    historique.save
  end

  private

  def placeparking_params
    params.require(:placeparking).permit(:occupied)
  end
end
