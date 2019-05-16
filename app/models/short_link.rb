class ShortLink < ApplicationRecord
  validates :original_url, presence: true
end
