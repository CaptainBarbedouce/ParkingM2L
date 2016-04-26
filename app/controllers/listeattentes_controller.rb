class ListeattenteController < ApplicationController
  before_action :set_listeattente, only: [:new, :create, :show, :edit, :update]
  before_action :authorization, :only [:new, :create, :show, :edit, :update]

  def new
	@listeattente = Listeattente.new
  end

  def create
	@listeattente = Utilisateur.new(listeattente_params)
    respond_to do |format|
      if @listeattente.save
        format.html { redirect_to index_utilisateur_path, notice: "Mise en liste d'attente" }
      else
        format.html { render :new }
      end
    end
  end
	
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
     if @listeattente.nil?
        fail ActiveRecord::RecordNotFound
      elsif @listeattente.update(listeattente_params)
        format.html { redirect_to index_administrateur_path, notice: 'Position mise à jour.' }
      else
        format.html { render :edit }
      end
    end
  end

  private 

  def authorization
    redirect_to root_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted
  end

  def listeattente_params
    params.require(:listeattente).permit(:numPosition)
  end

  def set_listeattente
    @listeattente = Listeattente.find_by(utilisateur_id: current_utilisateur)
  end
end