require 'rails_helper'
require 'shared_examples_for_user'

RSpec.describe Manager, type: :model do
  it_behaves_like 'User'

  # Associations
  it { is_expected.to have_many(:projects).dependent(:destroy) }
end
