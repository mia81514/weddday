class User < ActiveRecord::Base
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  #正常使用者的使用限制
  USER_LIMIT = {
    :MAX_EVENT                   => 20,
    :MAX_QUESTION_COUNT          => 15,
    :MAX_QUESTIONNAIRE_PER_EVENT => 5,
    :MAX_SELECTION_PER_Q         => 10,
  }

  has_many :events

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name  = auth.info.name
      # user.photo = auth.info.image
    end
  end
end
