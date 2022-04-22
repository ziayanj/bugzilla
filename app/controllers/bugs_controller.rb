class BugsController < ApplicationController
  before_action :set_project, only: %i[create destroy]

  def create
    @bug = @project.bugs.create(bug_params)
    redirect_to project_path(@project)

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
    @bug = @project.bugs.find(params[:id])
    @bug.destroy
    redirect_to project_path(@project)
  end

  def show
    @bug = Bug.find(params[:id])
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :qa_id)
  end
end