class AdministrateursController < ApplicationController
  before_filter :authenticate, :authorization

  def index
    @listeplace = Placeparking.all
    @utilisateur = Utilisateur.where(admin: false)
    @listeattente = Listeattente.all
    @maxduration = Parkingduration.first
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic('Panneau Administrateur') do |username, password|
      username == 'admin' && password == 'password'
    end
  end

  def authorization
    redirect_to utilisateurs_path, notice: "Vous ne pouvez pas faire cela." unless current_utilisateur.compte_accepted && current_utilisateur.admin
  end
end
