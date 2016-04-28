class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    utilisateurs_path(current_utilisateur)
  end

  def after_inactive_sign_up_path_for(resource)
    new_utilisateurs_path
  end

  def maj_listeattente
    historiques = Historique.where(:date_fin => ["date_fin < ?", DateTime.now.end_of_day])
    historiques.each do |h|
      place = Placeparking.find(h.placeparkings_id)
      place.occupied = false
      place.save
      utilisateur_to_edit = Utilisateur.find(h.utilisateurs_id)
      utilisateur_to_edit.demande_reservation = true
      utilisateur_to_edit.save
    end

    placelibre = Placeparking.where(occupied: false)
    
    unless placelibre.empty?
      placelibre.each do |p|
        premier = Listeattente.find_by(numPosition: 1)
        if premier
          historique = Historique.new(utilisateur_id: premier.utilisateurs_id, placeparking_id: p.id, date_debut: DateTime.now, date_fin: DateTime.now + premier.duration.months)
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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u| 
      u.permit(:nom, :prenom, :tel, :email, :password, :password_confirmation, :ligues_id)
    end
  end
end
