class ShortLink < ApplicationRecord
  before_create :randomize_id
  VALID_EMAIL_REGEX = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/ix
  validates :original_url, presence: true,
                           format: { with: VALID_EMAIL_REGEX }
  def increment_view_count
    self.increment!(:view_count)
  end

  def expire_url
    self.update_attribute(:original_url, '/404.html')
  end

  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1000000000)
    end while ShortLink.where(id: self.id).exists?
  end
end
