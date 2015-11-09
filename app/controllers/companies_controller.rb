class CompaniesController < ApplicationController

  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all.order("created_at DESC").paginate(page: params[:page], per_page: 3)
  end

  def show
    @search   = Project.ransack(params[:q])
    @projects = @search.result.where(company_id: @company.id).paginate(page: params[:page], per_page: 3)
  end

  def new
    @company = Company.new
  end

  def edit
    authorize! :update, @company
  end

  def create

    begin
      @company = Company.new(company_params)
      @owner = true
      if @company.save
        CompanyUser.create(company_id: @company.id, user_id: current_user.id, owner: true)
        redirect_to @company, notice: 'Company was successfully created.'
      else
        render :new
      end
    rescue ActionController::ParameterMissing
      @company = Company.find(params[:company_id])
      CompanyUser.create(company_id: @company.id, user_id: current_user.id, owner: false)
      redirect_to @company
    end

  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @company
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description, :image)
  end
end