require 'rails_helper'

RSpec.describe Post, type: :model do

it { should belong_to(:user) }

  it { should validate_presence_of(:avatar) }
#simplified way of saying expect(subject.name).to eq 'somerandomname'

end