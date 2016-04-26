class HistoriquesController < ApplicationController
  before_action :set_duree_max, only: [:new, :create]
  before_action :maj_listeattente, only: [:create]

  def new
	@historique = Historique.new
  end

  def create
	@historique = Historique.new(historique_params)
    datemax = Date.today + @dureemax.months

	respond_to do |format|
      if params[:date_debut] >= Date.today && params[:date_fin] <= datemax && params[:date_debut] <= params[:date_fin]
        if @historique.save
          format.html { redirect_to index_utilisateur_path, notice: 'Demande enregistée.' }
        else
          format.html { render :new, notice: 'Donnée invalide.' }
        end
      else
        format.html { render :new, notice: 'Donnée invalide.' }
      end
    end
  end

  private

  def set_duree_max
    @dureemax = Parking.duration.maxduration
  end

  def historique_params
    params.require(:historique).permit(:utilisateur_id, :placeparking_id, :date_debut, :date_fin)
  end
end
