class User < ApplicationRecord
  has_many :hits

  # We can remove this method but kept it considering we are using this at other places
  # If we remove this method then we'll have to move this logic to quota handler concern
  # TODO: Rename the method to `hits_count`
  def count_hits
    Rails.cache.read("#{self.id}_hits_count") || 0
  end
end
