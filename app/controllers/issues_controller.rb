class IssuesController < ApplicationController
  before_action :get_scheme
  def index
    @issues = @scheme.issues.all
  end

  def show
    @issue = @scheme.issues.find(params[:id])
  end

  def new
    @issue = @scheme.issues.new
  end

  def create
    @issue = @scheme.issues.new(issue_params)
    @issue.user = current_user
    if @issue.save
      redirect_to scheme_issues_path(@scheme)
    else
      render action: :new
    end
  end

  private

  def get_scheme
    @scheme = Scheme.find(params[:scheme_id])
  end

  def issue_params
    params.require(:issue).permit(
      :urn, :location_id, :scheme_priority_id, :resident_id, :description,
      :trade, :status
    )
  end
end
