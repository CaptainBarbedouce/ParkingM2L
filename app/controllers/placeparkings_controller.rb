class PlaceparkingsController < ApplicationController
  before_filter :authorization

  def index
    @listeplaces = Placeparking.all
  end
  
  def show
    @placeparking = Placeparking.find(params[:id])
    @historique = Historique.where(placeparkings_id: @placeparking)
    render 'administrateurs/historique'
  end

  def edit
    @placeparking = Placeparking.find(params[:id])
    @historique = Historique.new
    render 'administrateurs/attributionmanuelleplace'
  end

  def update
    dureemax = Parkingduration.first
    @placeparking = Placeparking.find(params[:id])
    @placeparking.occupied = true 
    @placeparking.save
    historique = Historique.new
    historique.date_debut = DateTime.now
    historique.utilisateurs_id = params[:utilisateurs_id]
    historique.date_fin = DateTime.now + dureemax.maxduration.months
    historique.placeparkings_id = @placeparking.id
    historique.save
    utilisateur_to_edit = Utilisateur.find(params[:utilisateurs_id])
    utilisateur_to_edit.demande_reservation = false
    utilisateur_to_edit.save
    redirect_to administrateurs_path, notice: 'Place attribuée'
  end

  private

  def authorization
    redirect_to utilisateurs_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted && current_utilisateur.admin
  end
end
