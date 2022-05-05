class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy add_user remove_user]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /projects or /projects.json
  def index
    @projects = policy_scope(Project)
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    authorize Project.find(params[:id])
  end

  # POST /projects or /projects.json
  def create
    @manager = User.find(current_user.id)
    authorize Project
    @project = @manager.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    authorize Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_user
    user = User.find(params[:user])

    case user.type
    when 'Developer'
      @project.developers << user
    when 'Qa'
      @project.qas << user
    end

    respond_to do |format|
      format.js { render js: 'window.top.location.reload(true);' }
    end
  end

  def remove_user
    user = User.find(params[:user])

    case user.type
    when 'Developer'
      @project.developers.destroy(user)
    when 'Qa'
      @project.qas.destroy(user)
    end

    respond_to do |format|
      format.js { render js: 'window.top.location.reload(true);' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:title)
  end
end
