require 'rails_helper'

RSpec.describe Note, type: :model do
  it { is_expected.to validate_absence_of :title }
end
