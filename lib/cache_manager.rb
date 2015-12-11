class CacheManager
  def self.cache
    Rails.cache
  end

####################
# login
####################
  def self.get_current_user(key)
    user_id = cache.read(key)
    return nil if user_id.nil? || (user = User.find(user_id.to_i) rescue nil).nil?
    self.extend_expiry!(key, user_id)
    return user
  end

  def self.set_user!(user_id)
    login_key = self.gen_login_key
    self.extend_expiry!(login_key, user_id)
    return login_key
  end

  def self.del_user!(login_key)
    cache.delete(login_key)
  end

  def self.gen_login_key
    return SecureRandom.random_bytes(256)
  end

  def self.extend_expiry!(login_key, user_id)
    cache.write(login_key, user_id, :expires_in => 1.day)
  end
end
