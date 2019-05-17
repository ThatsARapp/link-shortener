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

  context '#increment_view_count' do
    it 'increments view_count by one' do
      short_link = ShortLink.create(original_url: "https://google.com")
      expect{short_link.increment_view_count}.to change{short_link.view_count}.by(1)
    end
  end

  context '#expire_url' do
      it 'sets original_url to 404' do
        short_link = ShortLink.create(original_url: "https://google.com")
        short_link.expire_url
        expect(short_link.original_url).to eq '/404.html'
      end
  end

  context '#randomize_id' do
    it 'ensures ids are non sequential' do
      short_link1 = ShortLink.create(original_url: "https://google.com")
      short_link2 = ShortLink.create(original_url: "https://google.com")
      expect(short_link2.id - short_link1.id).not_to eq 1
    end
  end
end
