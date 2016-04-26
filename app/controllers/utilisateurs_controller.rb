class UtilisateurController < ApplicationController
  before_action :set_utilisateur, only: [:edit, :update, :index]
  before_action :authorization, only: [:edit, :update]
  before_action :uselessaction, only: [:new, :create]
  
  def index
    @historique = Historique.where(utilisateur_id: current_utilisateur)
    @listeattente = Listeattente.find_by(utilisateur_id: current_utilisateur)
    
    @choix = 0
    if @listeattente
      @choix = 1
    elsif @historique
      @historique.each do |h|
        @choix = 2 if Date.today >= h.date_fin && Date.today <= h.date_debut
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
        format.html { redirect_to index_utilisateurs_path, notice: 'Nouveau compte créé.' }
      else
        format.html { render :new, notice: 'Données invalide.' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @utilisateur.nil?
        fail ActiveRecord::RecordNotFound
      elsif @utilisateur.update(utilisateur_params_update)
        format.html { redirect_to @utilisateur, notice: 'Compte mis à jour.' }
      else
        format.html { render :edit }
      end
    end
  end

  private 

  rescue_from ActiveRecord::RecordNotFound do
    render action: 'utilisateur_missing', status: 404
  end

  def utilisateur_params_create
    params.require(:utilisateur).permit(:username, :mail, :password, :password_confirmation,
    	                                :nom, :prenom, :tel, :ligue_id)
  end

  def utilisateur_params_update
    params.require(:utilisateur).permit(:password, :password_confirmation,
    	                                :nom, :prenom, :adresse, :cp, :ville, :tel)
  end

  def set_utilisateur
  	@utilisateur = Utilisateur.find(current_utilisateur)
  	fail ActiveRecord::RecordNotFound if @utilisateur.nil?
  end

  def authorization
    redirect_to index_utilisateur_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.id == @utilisateur.id
  end

  def uselessaction
    redirect_to index_utilisateur_path, notice: "Compte déjà existant." unless current_utilisateur.nil?
  end
end
