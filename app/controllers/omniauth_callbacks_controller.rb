class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    p '________________________'
    p request.env["omniauth.auth"].provider
    p '________________________'
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      session['provider']= request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  alias_method :google_oauth2, :all
  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :linkedin, :all
  alias_method :github, :all
end

