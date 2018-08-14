class IssuesController < ApplicationController
  before_action :get_scheme
  def index
    @filterrific = initialize_filterrific(
      @scheme.issues,
      params[:filterrific],
      :select_options => {
        sorted_by: Issue.options_for_sorted_by,
        locations: @scheme.options_for_locations,
        statuses: Issue::Statuses,
        users: User.all.collect {|x| [x.email, x.id]},
        priorities: @scheme.scheme_priorities.collect {|x| [x.name, x.id]},
        trades: Issue.all.pluck(:trade).uniq,
      }
    ) or return
    if params[:chart].present?
      @issues = @filterrific.find.group(params[:chart]).unscope(:order).count
    else
      @issues = @filterrific.find.page(params[:page])
    end
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

  def edit
    @issue = @scheme.issues.find(params[:id])
  end

  def update
    @issue = @scheme.issues.find(params[:id])
    if @issue.update_attributes(issue_params)
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
