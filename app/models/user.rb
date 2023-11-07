class User < ApplicationRecord
  has_many :hits

  # We can remove this method but kept it considering we are using this at other places
  def count_hits
    Rails.cache.read("#{self.id}_hits_count") || 0
  end
end
