require 'rails_helper'

RSpec.describe Project, type: :model do
  # Associations
  it { is_expected.to belong_to(:manager) }
  it { is_expected.to have_many(:bugs).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:developers).join_table(:projects_developers) }
  it { is_expected.to have_and_belong_to_many(:qas).join_table(:projects_qas) }

  # Validations
  it { is_expected.to validate_presence_of(:title) }

  describe 'uniqueness' do
    subject { Project.new(title: 'Test') }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end
end
