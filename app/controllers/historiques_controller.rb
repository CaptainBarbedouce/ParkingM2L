class HistoriquesController < ApplicationController
  before_action :set_duree_max, only: [:new, :create]
  before_action :maj_listeattente, only: [:create]
  before_filter :authorization

  def new
    @historique = Historique.new
  end

  def create
    @historique = Historique.new(historique_params)
    @maxduration = Parkingduration.first
    datemax = DateTime.now + @maxduration.maxduration.months
    datedebut = DateTime.strptime(historique_params[:date_debut], '%m/%d/%Y')
    dureeutilisateur = params[:duree].to_i
    datefin = datedebut + dureeutilisateur.months

    if datedebut >= DateTime.now && datefin <= datemax && datedebut <= datefin
      parking = Placeparking.find_by(occupied: false)
      if parking
        @historique.date_debut = datedebut
        @historique.placeparkings_id = parking.id
        @historique.utilisateurs_id = current_utilisateur.id
        @historique.date_fin = datefin
        if @historique.save!
          parking.occupied = true
          parking.save
          current_utilisateur.demande_reservation = false
          current_utilisateur.save
          redirect_to utilisateurs_path, notice: 'Demande enregistée.'
        else
          redirect_to utilisateurs_path, notice: 'Données invalide.'
        end
      else
        liste = Listeattente.new
        liste.utilisateurs_id = current_utilisateur.id
        liste.duration = dureeutilisateur
        last_position = Listeattente.last
        if last_position
          liste.numPosition = last_position.numPosition + 1
        else
          liste.numPosition = 1
        end
        liste.save!
        redirect_to utilisateurs_path, notice: "Aucune place disponible, vous avez été placé dans la liste d'attente" if liste.save
      end
    else
      redirect_to utilisateurs_path, notice: 'Données invalide.'
    end
  end

  private

  def authorization
    redirect_to utilisateurs_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted
  end

  def set_duree_max
    @dureemax = Parkingduration.first
  end

  def historique_params
      params.require(:historique).permit(:date_debut)
  end
end
