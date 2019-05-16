require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  context 'validation tests' do
    it 'ensures url is present' do
      short_link = ShortLink.new().save
      expect(short_link).to eq false
    end
  end
end
