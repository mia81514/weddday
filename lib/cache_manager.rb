class CacheManager
  def self.cache
    Rails.cache
  end

####################
# login
####################
  def self.get_current_user(key)
    user_id = cache.read(key)
    return nil if user_id.nil? || (user = User.where(user_id).first).nil?
    set_new_user(key, user_id) #延長expire time
    return user
  end

private
  def set_new_user(login_key, user_id)
    cache.write(login_key, user_id, :expires_in => 1.day)
  end
end
