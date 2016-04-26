class AdministrateursController < ApplicationController
  before_action :set_utilisateur, only: [:index, :edit, :update, :index]
  before_action :authorization, only: [:edit, :update]
  before_action :uselessaction, only: [:new, :create]
  
  def index 
	  @historique = Historique.where(utilisateurs_id: current_utilisateur)
	  @listeattente = Listeattente.where(utilisateurs_id: current_utilisateur)
	  
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
        format.html { redirect_to root_path, notice: 'Nouveau compte créé.' }
      else
        format.html { render :new, notice: 'Donnée invalide.' }
      end
    end
  end

  def edit
  end

  def update
    # Ces 2 lignes ci-dessous sont a commenté
    # une fois que le compte de l'administrateur a été créé

    # 
    respond_to do |format|
      if @utilisateur.nil?
        fail ActiveRecord::RecordNotFound
      elsif @utilisateur.update(utilisateur_params_update)
        sign_in(@utilisateur, bypass: true)
        format.html { redirect_to utilisateurs_path, notice: 'Compte mis à jour.' }
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
    params.require(:utilisateur).permit(:username, :nom, :prenom, :tel, :email, 
                                        :password, :password_confirmation, :ligues_id)
  end

  def utilisateur_params_update
    params.require(:utilisateur).permit(:nom, :prenom, :tel, :email,
                                        :password, :password_confirmation, 
                                        :adresse, :cp, :ville, :admin, :compte_accepted)
  end

  def set_utilisateur
  	@utilisateur = current_utilisateur
  	fail ActiveRecord::RecordNotFound if @utilisateur.nil?
  end

  def authorization
    redirect_to root_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.admin
  end

  def uselessaction
    redirect_to utilisateurs_path, notice: "Compte déjà existant." unless current_utilisateur.nil?
  end
end
