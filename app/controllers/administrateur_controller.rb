class AdministrateurController < ApplicationController
  def index
  	@listeplace = Placeparking.all
  	@utilisateur = Utilisateur.all
  	@listeattente = Listeattente.all
  end
end
