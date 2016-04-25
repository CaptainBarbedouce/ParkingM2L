class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def maj_listeattente
    historiques = Historique.where(date_fin <= Date.today)
    historiques.each do |h|
      place = Placeparking.find(h.placeparking_id)
      place.occupied = false
      place.save
    end
    placelibre = Placeparking.where(occupied: false)
    if placelibre
      placelibre.each do |p|
        premier = Listeattente.find_by(numPosition: 1)
        historique = Historique.new(utilisateur_id: premier.utilisateur_id, placeparking_id: p.id, date_debut: Date.today, date_fin: Date.today + premier.duration.months)
        historique.save
        listeattente = Listeattente.all
        listeattente.each do |l|
          l.numPosition -= 1
          l.save
        end
        listesupp = Listeattente.find_by(numPosition: 0)
        listesupp.destroy
      end
    end
  end
end
