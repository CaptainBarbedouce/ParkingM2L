class ParkingdurationsController < ApplicationController
  def edit
  	@maxduration = Parkingduration.first
  end

  def update
    @maxduration = Parkingduration.first
    @maxduration.update(pd_params)
    redirect_to administrateurs_path, notice: 'Durée maximum mise à jour.'
  end

  private

  def pd_params
    params.require(:parkingduration).permit(:maxduration)
  end
end
