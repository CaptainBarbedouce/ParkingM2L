class AdministrateursController < ApplicationController
  def index
    @listeplace = Placeparking.all
    @utilisateur = Utilisateur.where(admin: false)
    @listeattente = Listeattente.all
    @maxduration = Parkingduration.first
  end
end
