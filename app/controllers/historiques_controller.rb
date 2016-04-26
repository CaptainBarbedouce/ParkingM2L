class HistoriquesController < ApplicationController
  before_action :set_duree_max, only: [:new, :create]
  before_action :maj_listeattente, only: [:create]
  before_action :authorization, only: [:new, :create]
  #before_action :useless_aciton, only: [:new, :create]

  def new
	  @historique = Historique.new
  end

  def create
	  @historique = Historique.new(historique_params)
    datemax = DateTime.now + @maxduration.maxduration.months
    datedebut = historique_params[:date_debut]
    dureeutilisateur = params[:duree].to_i
    datefin = datedebut.to_datetime + dureeutilisateur.months

    if datedebut >= DateTime.now && datefin <= datemax && datedebut <= datefin
      parking = Placeparking.find_by(occupied: false)
      if parking
        @historique.placeparking_id = parking.id
        @historique.utilisateurs_id = current_utilisateur
        @historique.date_fin = datefin
        if @historique.save
          redirect_to utilisateurs_path, notice: 'Demande enregistée.'
        else
          redirect_to utilisateurs_path, notice: 'Donnée invalide.'
        end
      else
        liste = Listeattente.new
        liste.utilisateurs_id = current_utilisateur
        liste.duration = dureeutilisateur
        redirect_to utilisateurs_path, notice: "Aucune place disponible vous êtes sur la liste d'attente" if liste.save
      end
    else
      redirect_to utilisateurs_path, notice: 'Données invalide.'
    end
  end

  private

  def authorization
    redirect_to root_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted
  end

  def set_duree_max
    @maxduration = Parkingduration.first
  end

  def useless_aciton
    redirect_to utilisateurs_path, notice: "Vous avez déjà une place de parking qui vous a été attribuée"
  end

  def historique_params
    params.require(:historique).permit(:utilisateur_id, :placeparking_id, :date_debut, :date_fin)
  end
end
