class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :pictures, class_name: "Picture"
  ROLES = %i[admin user]
  def admin?
    self.role == "admin"
  end

  def user?
    self.role == "user"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = "#{auth.uid}@fb.com"
      user.password = Devise.friendly_token[0,20]
      user.role = 'user'
    end
  end
end
