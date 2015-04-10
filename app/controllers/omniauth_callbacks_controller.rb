class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
		# provider_ignores_state :true
	    user = AdminUser.from_omniauth request.env["omniauth.auth"]
	    if user
	      flash.notice = "Signed in!"
	      sign_in_and_redirect user
	      # redirect_to :root
	    else
	      flash.notice = "We couldn't sign you in because: " + user.errors.full_messages.to_sentence
	      redirect_to new_user_session_url
	      # redirect_to :root
	    end
	end

	# alias_method :google_oauth2, :all
end
