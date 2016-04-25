class UtilisateursController < ApplicationController
  before_action :set_utilisateur, only: [:edit, :update, :index]
  before_action :authorization, only: [:edit, :update]
  before_action :uselessaction, only: [:new, :create]
  
  def index 
	  @historique = Historique.where(utilisateurs_id: current_utilisateur)
	  @listeattente = Listeattente.where(utilisateurs_id: current_utilisateur)
	  if @historique
      @historique.each do |h|
	      if h.date_fin <= Date.today
          @choix = 1
	      elsif h.date_fin > Date.today && @listeattente.nil?
	  	    @choix = 2
	      elsif h.date_fin > Date.today && @listeattente
	  	    @choix = 3
	      else
          @choix = 0
	  	  end
	    end
	  end
  end

  def new
    @utilisateur = Utilisateur.new
  end

  def create
	  @utilisateur = Utilisateur.new(user_params_create)
    @utilisateur.admin = true
    @utilisateur.compte_accepted = true
    respond_to do |format|
      if @utilisateur.save
        format.html { redirect_to root_path, notice: 'Nouveau compte créé.' }
        format.json { redirect_to root_path, status: 302, location: @utilisateur }
      else
        format.html { render :new, notice: 'Donnée invalide.' }
        format.json { render json: @utilisateur.errors, status: 422 }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @utilisateur.nil?
        fail ActiveRecord::RecordNotFound
      elsif @utilisateur.update(user_params_update)
        format.html { redirect_to @utilisateur, notice: 'Compte mis à jour.' }
        format.json { render :show, status: 200, location: @utilisateur }
      else
        format.html { render :edit }
        format.json { render json: @utilisateur.errors, status: 422 }
      end
    end
  end

  private 

  rescue_from ActiveRecord::RecordNotFound do
    render action: 'utilisateur_missing', status: 404
  end

  def user_params_create
    params.require(:utilisateur).permit(:username, :nom, :prenom, :tel, :mail, 
                                        :password, :password_confirmation, :ligue_id)
  end

  def user_params_update
    params.require(:utilisateur).permit(:nom, :prenom, :tel,
                                        :password, :password_confirmation, 
                                        :adresse, :cp, :ville)
  end

  def set_utilisateur
  	@utilisateur = Utilisateur.find(current_utilisateur)
  	fail ActiveRecord::RecordNotFound if @utilisateur.nil?
  end

  def authorization
    redirect_to root_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.id == @utilisateur.id
  end

  def uselessaction
    redirect_to index_utilisateur_path, notice: "Compte déjà existant." unless current_utilisateur.nil?
  end
end
