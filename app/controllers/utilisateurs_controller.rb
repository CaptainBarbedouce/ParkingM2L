class UtilisateursController < ApplicationController
  before_action :set_utilisateur, only: [:index, :edit, :update]
  before_action :authorization, only: [:edit, :update, :destroy]
  before_action :uselessaction, only: [:new, :create]
  
  def index 
	  @historique = Historique.where(utilisateurs_id: current_utilisateur)
	  @listeattente = Listeattente.find_by(utilisateurs_id: current_utilisateur)
    @createhistorique = Historique.new
    @maxduration = Parkingduration.first
	  
    @choix = 0
    if @listeattente.present?
      @choix = 1
    elsif @historique.present?
      @historique.each do |h|
        if Date.today >= h.date_fin && Date.today <= h.date_debut
          @choix = 2
          @parking = h.libel
        end
      end
    end
  end

  def new
    @utilisateur = Utilisateur.new
  end

  def create
	  @utilisateur = Utilisateur.new(utilisateur_params_create)
    
    respond_to do |format|
      if @utilisateur.save
        format.html { redirect_to root_path, notice: 'Nouveau compte créé.' }
      else
        format.html { render new_utilisateur_path, notice: 'Donnée invalide.' }
      end
    end
  end

  def edit
    @utilisateur_to_edit = Utilisateur.find(params[:id])
  end

  def update
    @utilisateur_to_edit = Utilisateur.find(params[:id]) if params[:id]
    respond_to do |format|
      if @utilisateur_to_edit.id != current_utilisateur && current_utilisateur.admin
        if params[:reset_password]
          @utilisateur_to_edit.send_reset_password_instructions
          if @utilisateur_to_edit.save
            format.html { redirect_to administrateurs_path, notice: 'Mot de passe réinitialisé.' }
          else
            format.html { render :edit }
          end
        elsif utilisateur_params_update[:compte_accepted]
          if @utilisateur_to_edit.update(utilisateur_params_update)
            format.html { redirect_to administrateurs_path, notice: 'Utilisateur Validé.' }
          else
            format.html { render '_editionadministrateur' }
          end
        else
          format.html { render '_editionadministrateur' }
        end
      elsif params[:password_confirmation]
        if @utilisateur.update(utilisateur_params_update)
          sign_in(@utilisateur, bypass: true)
          format.html { redirect_to utilisateurs_path, notice: 'Compte mis à jour.' }
        else
          format.html { render :edit }
        end
      elsif @utilisateur.update(utilisateur_params_update_without_password)
        sign_in(@utilisateur, bypass: true)
        format.html { redirect_to utilisateurs_path, notice: 'Compte mis à jour.' }
      else
        format.html { render :edit } 
      end
    end
  end

  def destroy
    @utilisateur_to_delete = Utilisateur.find(params[:id])
    if @utilisateur_to_delete.nil?
      fail ActiveRecord::RecordNotFound
    else
      @utilisateur_to_delete.destroy
      respond_to do |format|
        format.html { redirect_to administrateurs_path, notice: 'Utilisateur Supprimé.' }
        format.json { head :no_content, status: 204 }
      end
    end
  end

  private

  rescue_from ActiveRecord::RecordNotFound do
    render action: 'utilisateur_missing', status: 404
  end

  def utilisateur_params_create
    params.require(:utilisateur).permit(:nom, :prenom, :tel, :email, 
                                        :password, :password_confirmation, :ligues_id)
  end

  def utilisateur_params_update
    params.require(:utilisateur).permit(:nom, :prenom, :tel, :email,
                                        :password, :password_confirmation, 
                                        :adresse, :cp, :ville, :admin, :compte_accepted)
  end

  def utilisateur_params_update_without_password
    params.require(:utilisateur).permit(:nom, :prenom, :tel, :email,
                                        :adresse, :cp, :ville, :admin, :compte_accepted)
  end  

  def set_utilisateur
  	@utilisateur = current_utilisateur
  	fail ActiveRecord::RecordNotFound unless @utilisateur
  end

  def authorization
    redirect_to utilisateurs_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted
  end

  def uselessaction
    redirect_to utilisateurs_path, notice: "Compte déjà existant." unless current_utilisateur.nil?
  end
end
