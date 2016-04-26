class HistoriquesController < ApplicationController
	before_action :set_duree_max, only: [:new, :create]
    before_action :maj_listeattente, only: [:create]

	def new
	  @historique = Historique.new
	end

	def create
	  @historique = Historique.new(historique_params)
      datemax = Date.today + @dureemax.maxduration.months
      datedebut = historique_params[:date_debut].to_datetime
      dureeutilisateur = params[:duree].to_i
      datefin = datedebut + dureeutilisateur.months
	  respond_to do |format|
        if datedebut >= Date.today && datefin <= datemax && datedebut <= datefin
          @historique.date_fin = datefin
          if @historique.save
            format.html { redirect_to utilisateurs_path, notice: 'Demande enregistée.' }
          else
            format.html { redirect_to utilisateurs_path, notice: 'Donnée invalide.' }
          end
        else
          format.html { redirect_to utilisateurs_path, notice: 'Donnée invalide.' }
        end
      end
	end

	private

	def set_duree_max
	  @dureemax = Parkingduration.first
	end

	def historique_params
      params.require(:historique).permit(:utilisateur_id, :placeparking_id, :date_debut, :date_fin)
	end
end
