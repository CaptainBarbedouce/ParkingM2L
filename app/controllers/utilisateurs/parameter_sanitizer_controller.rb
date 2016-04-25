class User::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:username, :nom, :prenom, :tel, :email, :password, :password_confirmation, :confirmation_token, :confirmation_sent_at])
  end
end