class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:show, :new, :index, :destroy, :edit, :update ]

  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @project = @company.projects.new
  end

  def edit
  end

  def create
    @company = current_user.companies.find(params[:company_id])
    @project = @company.projects.build(project_params.merge(user_id: current_user.id))
    if @project.save
      redirect_to [@company, @project], notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    if  @project.update(project_params)
      if CompanyUser.where(user_id: current_user.id, company_id: @company.id, owner: true).present?
        redirect_to company_path(@company), notice: 'Project successfully updated.'
      else
        redirect_to company_project_path(@company, @project), notice: 'Project successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to company_path(@company)
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :user_id, :company_id, :cpu, :ram, :hdd, :aasm_state)
    end
end
