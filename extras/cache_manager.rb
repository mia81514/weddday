class CacheManager
  def self.cache
    Rails.cache
  end

#===========================
# login relation
#===========================
  def self.put_new_user_to_cache(loginkey, user_id)
    cache.write(loginkey, user_id, :expires_in => 1.day)
  end

  def self.get_current_user(key)
    user_id = cache.read(key)
    return nil if user_id.nil?
    return nil if (user = User.where(user_id).first).nil?
    self.put_new_user_to_cache(key, user_id) #用來延長expire time
    return user
  end
end
