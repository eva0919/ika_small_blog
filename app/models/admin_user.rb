class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]


  # def password_required?
    # provider.present? ? false : super
  # end

  def self.from_omniauth(auth)

  	user = AdminUser.where(email: auth.info.email).first
  	if user
	  	user.update_attributes email: auth.info.email
	else
		user = AdminUser.create(email: auth.info.email)
	end
    # user = where(email: auth.info.email).first || where(auth.slice(:provider, :uid)).first || new
    # user.update_attributes provider: auth.provider,
    #                        uid:      auth.uid,
    #                        email:    auth.info.email
    # user.name ||= auth.info.name # note: Devise seems to wrap this in the DB write for session info
    # user
    user
  end
end
