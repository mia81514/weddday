require "bcrypt"
class User < ActiveRecord::Base
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name  = auth.info.name
      # user.photo = auth.info.image
    end
  end

  def set_sign_in!(info)
    info[:last_sign_in_at] = self.current_sign_in_at
    info[:current_sign_in_at] = Time.now
    info[:sign_in_count] = self.sign_in_count+1
    info[:last_sign_in_ip] = self.current_sign_in_ip
    self.update_attributes!(info)
  end

  def check_password?(pwd)
    encrypted_pwd = BCrypt::Password.new(self.encrypted_password)
    return pwd == encrypted_pwd
  end
end
