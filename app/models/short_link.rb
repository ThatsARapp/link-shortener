class ShortLink < ApplicationRecord
  URL_CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
  VALID_URL_REGEX = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/ix

  before_create :randomize_id
  validates :original_url, presence: true,
                           format: { with: VALID_URL_REGEX }
  def increment_view_count
    self.increment!(:view_count)
  end

  def expire_url
    self.update_attribute(:original_url, '/404.html')
  end


  def self.encode_url(id)
    return URL_CHARACTERS[0] if id == 0
     path = ''
    base = URL_CHARACTERS.length
    while id > 0
      path << URL_CHARACTERS[id.modulo(base)]
      id /= base
    end
    path.reverse
  end

  def self.decode_url(path)
    id = 0
    base = URL_CHARACTERS.length
    path.each_char { |c| id = id * base + URL_CHARACTERS.index(c) }
    id
  end

  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1000000000)
    end while ShortLink.where(id: self.id).exists?
  end
end
