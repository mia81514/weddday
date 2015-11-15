require "bcrypt"
class User < ActiveRecord::Base
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :events

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

  def self.set_sign_up!(email, pwd)
    return {:error => "EmailInvalid"} if email.match(User.email_regexp).nil?
    return {:error => "EmailExisted"} if User.where(:email => email).exists?
    return {:error => "PasswordInvalid"} if not User.password_length.include?(pwd.length)
    User.create!({:email => email, :password => pwd})
    return {}
  end

  def check_password?(pwd)
    return BCrypt::Password.new(self.encrypted_password).is_password?(pwd)
  end
end
