class PlaceparkingsController < ApplicationController
  def index
    @listeplaces = Placeparking.all
  end
  
  def show
    @placeparking = Placeparking.find(params[:id])
    @historique = Historique.where(placeparkings_id: @placeparking)
    render 'administrateurs/_historique'
  end

  def edit
    @placeparking = placeparking.find(params[:id])
    render 'administrateurs/_attributionmanuelleplace'
  end

  def update
    @placeparking = Placeparking.find(params[:id])
    @placeparking.occupied = true 
    @placeparking.save
    historique = historique.new
    historique.date_debut = DateTime.now
    historique.utilisateurs_id = params[:utilisateur_id]
    duree = params[:duree].to_i
    historique.date_fin = DateTime.now + duree.months
    historique.placeparkings_id = @placeparking.id
    historique.save
    redirect_to administrateurs_path
  end
end
