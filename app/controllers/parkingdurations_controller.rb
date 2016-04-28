class ParkingdurationsController < ApplicationController
  before_filter :authorization

  def edit
  	@maxduration = Parkingduration.first
  end

  def update
    @maxduration = Parkingduration.first
    @maxduration.update(pd_params)
    redirect_to administrateurs_path, notice: 'Durée maximum mise à jour.'
  end

  private

  def authorization
    redirect_to utilisateurs_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted && current_utilisateur.admin
  end

  def pd_params
    params.require(:parkingduration).permit(:maxduration)
  end
end
