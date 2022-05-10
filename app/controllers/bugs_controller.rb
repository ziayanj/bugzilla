class BugsController < ApplicationController
  before_action :set_project, only: %i[create destroy]

  def create
    authorize Bug
    @bug = Bug.new(bug_params)
    @bug.creator = current_user
    @bug.project = @project
    @bug.save
    # redirect_to project_path(@project)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_url(@project), notice: "Bug was successfully reported." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
        # redirect_to new_project_bug_path(@project, @bug)
      end
    end

    # respond_to do |format|
    #   if @project.save
    #     format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
    #     format.json { render :show, status: :created, location: @project }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @project.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    authorize Bug
    @bug = @project.bugs.find(params[:id])
    @bug.destroy
    redirect_to project_path(@project)
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def new
    @bug = Bug.new
    @project = Project.find(params[:project_id])
  end

  def assign
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.find(params[:id])

    if @bug.developer.nil?
      @bug.update!(developer_id: current_user.id)
    end

    respond_to do |format|
      format.js { render js: 'window.top.location.reload(true);' }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :category, :status, :screenshot)
  end
end