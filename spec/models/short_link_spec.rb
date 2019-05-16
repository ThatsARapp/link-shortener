require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  context 'validation tests' do
    it 'ensures url is not missing' do
      short_link = ShortLink.new().save
      expect(short_link).to eq false
    end

    it 'ensures the url is a not an invalid format' do
      short_link = ShortLink.new(original_url: "thisisnotvalid").save
      expect(short_link).to eq false
    end

    it 'ensures the url is a valid format' do
      short_link = ShortLink.new(original_url: "https://google.com").save
      expect(short_link).to eq true
    end
  end
end
