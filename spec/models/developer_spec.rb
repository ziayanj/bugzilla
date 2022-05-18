require 'rails_helper'
require 'shared_examples_for_user'

RSpec.describe Developer, type: :model do
  it_behaves_like 'User'

  # Associations
  it { is_expected.to have_many(:bugs).dependent(:nullify) }
  it { is_expected.to have_and_belong_to_many(:projects).join_table(:projects_developers) }
end
