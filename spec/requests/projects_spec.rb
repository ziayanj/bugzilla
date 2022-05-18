require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  before do
    @manager = Manager.create(password: 'random',
                              email: 'manager@user.com',
                              name: 'manager')

    post user_session_path, params: {
      user: {
        email: @manager.email, password: @manager.password
      }
    }
    follow_redirect!
  end

  let(:valid_attributes) {
    {
      title: 'Test ProjectsController',
      description: 'Test Description',
      manager_id: @manager.id
    }
  }

  let(:invalid_attributes) {
    {
      manager_id: @manager.id,
      title: ''
    }
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      @manager.projects.create! valid_attributes
      get projects_url
      expect(response).to be_successful
      expect(response.body).to include('Test ProjectsController')
    end
  end

  describe 'GET /show' do
    it 'renders a succesful response' do
      project = Project.create! valid_attributes
      get project_url(project)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      project = Project.create! valid_attributes
      get edit_project_url(project)
      expect(response).to be_successful
    end
  end

  describe 'GET /create' do
    context 'with valid parameters' do
      it 'creates a new Project' do
        expect {
          post projects_url, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
        project = Project.last
        expect(project.title).to eq('Test ProjectsController')
        expect(project.description).to eq('Test Description')
      end

      it 'redirects to the created project' do
        post projects_url, params: { project: valid_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Project' do
        expect {
          post projects_url, params: { project: invalid_attributes }
        }.to change(Project, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: 'Updated'
        }
      end

      it 'updates the requested project' do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(project.title).to eq('Updated')
      end

      it 'redirects to the project' do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(response).to redirect_to(project_url(project))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested project' do
      project = Project.create! valid_attributes
      expect {
        delete project_url(project)
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects list' do
      project = Project.create! valid_attributes
      delete project_url(project)
      expect(response).to redirect_to(projects_url)
    end
  end

  let(:developer) {
    Developer.create(password: 'random',
                     email: 'dev@user.com',
                     name: 'dev')
  }

  let(:qa) {
    Qa.create(password: 'random',
              email: 'qa@user.com',
              name: 'qa')
  }

  describe 'GET /add_user' do
    it 'adds the requested developer' do
      project = Project.create! valid_attributes
      get add_user_project_path(project, user: developer), xhr: true
      expect(project.developers).to include(developer)
    end

    it 'adds the requested qa' do
      project = Project.create! valid_attributes
      get add_user_project_path(project, user: qa), xhr: true
      expect(project.qas).to include(qa)
    end
  end

  describe 'GET /remove_user' do
    it 'removes the requested developer' do
      project = Project.create! valid_attributes
      get add_user_project_path(project, user: developer), xhr: true
      get remove_user_project_path(project, user: developer), xhr: true
      expect(project.developers).to_not include(developer)
    end

    it 'removes the requested qa' do
      project = Project.create! valid_attributes
      get add_user_project_path(project, user: qa), xhr: true
      get remove_user_project_path(project, user: qa), xhr: true
      expect(project.qas).to_not include(qa)
    end
  end
end
