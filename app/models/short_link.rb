class ShortLink < ApplicationRecord
  VALID_EMAIL_REGEX = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/ix
  validates :original_url, presence: true,
                           format: { with: VALID_EMAIL_REGEX }
  def increment_view_count
    self.increment!(:view_count)
  end

end
