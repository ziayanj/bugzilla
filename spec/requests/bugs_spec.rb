require 'rails_helper'

RSpec.describe 'Bugs', type: :request do
  before do
    @qa = Qa.create(password: 'random',
                    email: 'qa@user.com',
                    name: 'qa')

    @manager = Manager.create(password: 'random',
                              email: 'manager@user.com',
                              name: 'manager')

    @project = @manager.projects.create(title: 'Test Bugs')

    post user_session_path, params: {
      user: {
        email: @qa.email, password: @qa.password
      }
    }
    follow_redirect!
  end

  let(:valid_attributes) {
    {
      title: 'Bug for testing',
      description: 'Test Description',
      deadline: '2023-05-09 18:58:00',
      category: :bug,
      status: :created,
      qa_id: @qa.id,
      project_id: @project.id
    }
  }

  let(:invalid_attributes) {
    {
      title: '',
      deadline: 'abcde',
      category: :bug,
      status: :created,
      qa_id: @qa.id,
      project_id: @project.id
    }
  }

  describe 'GET /show' do
    it 'renders a successful response' do
      bug = Bug.create! valid_attributes
      get project_bug_url(@project, bug)
      expect(response).to be_successful
      expect(response.body).to include('Bug for testing')
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_bug_url(@project)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      bug = Bug.create! valid_attributes
      get edit_project_bug_url(@project, bug)
      expect(response).to be_successful
      expect(response.body).to include('Bug for testing')
    end
  end

  describe 'GET /create' do
    context 'with valid parameters' do
      it 'creates a new Bug' do
        expect {
          post project_bugs_url(@project), params: { bug: valid_attributes }
        }.to change(Bug, :count).by(1)
        bug = Bug.last
        expect(bug.title).to eq('Bug for testing')
        expect(bug.description).to eq('Test Description')
        expect(bug.deadline).to eq('2023-05-09 18:58:00')
        expect(bug.category).to eq('bug')
        expect(bug.status).to eq('created')
      end

      it 'redirects to the parent project of the bug' do
        post project_bugs_url(@project), params: { bug: valid_attributes }
        expect(response).to redirect_to(project_url(Bug.last.project))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Bug' do
        expect {
          post project_bugs_url(@project), params: { bug: invalid_attributes }
        }.to change(Bug, :count).by(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested bug' do
      bug = Bug.create! valid_attributes
      expect {
        delete project_bug_url(@project, bug)
      }.to change(Bug, :count).by(-1)
    end

    it 'redirects to the parent project of the bug' do
      bug = Bug.create! valid_attributes
      delete project_bug_url(@project, bug)
      expect(response).to redirect_to(project_url(@project))
    end
  end

  let(:developer) {
    Developer.create(password: 'random',
                     email: 'dev@user.com',
                     name: 'dev')
  }

  describe 'GET /assign' do
    it 'assigns the bug to the current developer' do
      delete destroy_user_session_path
      sign_in developer

      bug = Bug.create! valid_attributes
      get assign_project_bug_url(@project, bug), xhr: true
      bug.reload
      expect(bug.developer_id).to eq(developer.id)
    end
  end

  describe 'GET /resolve' do
    it 'resolves a bug of category `bug`' do
      bug = Bug.create! valid_attributes
      get resolve_project_bug_url(@project, bug), xhr: true
      bug.reload
      expect(bug.status).to eq('resolved')
    end

    it 'resolves a bug of category `feature`' do
      bug = Bug.create!(title: 'Bug for testing',
                        description: 'Test Description',
                        deadline: '2023-05-09 18:58:00',
                        category: :feature,
                        status: :created,
                        qa_id: @qa.id,
                        project_id: @project.id)
      get resolve_project_bug_url(@project, bug), xhr: true
      bug.reload
      expect(bug.status).to eq('completed')
    end
  end
end
