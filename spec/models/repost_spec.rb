require 'rails_helper'

RSpec.describe Repost, type: :model do
  it { is_expected.to validate_absence_of :title }
  it { is_expected.to validate_presence_of :repost_of }
end
