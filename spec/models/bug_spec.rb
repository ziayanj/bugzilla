require 'rails_helper'

RSpec.describe Bug, type: :model do
  # Associations
  it 'should belong to a project' do
    t = Bug.reflect_on_association(:project)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should belong to a creator' do
    t = Bug.reflect_on_association(:creator)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should belong to a developer' do
    t = Bug.reflect_on_association(:developer)
    expect(t.macro).to eq(:belongs_to)
  end

  # Validations
  let(:creator) {
    Qa.create(email: 'test@qa.com', password: 'random', name: 'abc')
  }
  let(:manager) {
    Manager.create(email: 'test@manager.com', password: 'random', name: 'test')
  }
  let(:proj) {
    Project.create(title: 'Project', manager_id: manager.id)
  }

  subject do
    described_class.new(title: 'Testing',
                        deadline: '2023-05-29 18:58:00',
                        category: :bug,
                        status: :created,
                        qa_id: creator.id,
                        project_id: proj.id)
  end

  it { is_expected.to validate_uniqueness_of(:title).scoped_to(:project_id) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a deadline' do
    subject.deadline = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a category' do
    subject.category = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it 'only has either .png or .gif screenshot attached' do
    bug = Bug.new
    bug.screenshot.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'random.txt')),
      filename: 'random.txt',
      content_type: 'application/txt'
    )
    bug.valid?
    expect(bug).to be_invalid
    expect(bug.errors.include?(:screenshot))
  end
end
