class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :pictures, class_name: "Picture"
  ROLES = %i[admin user]
  def admin?
    self.role == :admin
  end

  def user?
    self.role == :user
  end
end
