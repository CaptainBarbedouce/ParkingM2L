class PlaceparkingsController < ApplicationController
  before_action :authorization, only: [:index, :show, :edit, :update]

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

  def authorization
    redirect_to root_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted
  end

  def listeattente_params
    params.require(:listeattente).permit(:numPosition)
  end

  def placeparking_params
    params.require(:placeparking).permit(:occupied)
  end
end
