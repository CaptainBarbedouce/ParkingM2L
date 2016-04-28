class ListeattentesController < ApplicationController
  before_action :set_listeattente, only: [:edit, :update]
  before_filter :authorization

  def edit
    @listeattentes = Listeattente.all
    @listeattentes = 1 unless @listeattentes
    render 'administrateurs/editerlisteattente'
  end

  def update
    placelibre = Listeattente.where.not(utilisateurs_id: @listeattente.utilisateurs_id)
    placelibre = placelibre.where(numPosition: ["numPosition > ?", @listeattente.numPosition])
    
    unless placelibre.empty?
      placelibre.each do |l|
        l.numPosition += 1
        l.save
      end
    end

    @listeattente.numPosition = listeattente_params[:numPosition]
    @listeattente.save
    redirect_to administrateurs_path, notice: "Liste d'attente mise à jour"
  end

  private 

  def authorization
    redirect_to utilisateurs_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted
  end
  
  def listeattente_params
    params.require(:listeattente).permit(:numPosition)
  end

  def set_listeattente
    @listeattente = Listeattente.find(params[:id])
  end
end