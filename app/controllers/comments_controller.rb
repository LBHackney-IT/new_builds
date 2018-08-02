class CommentsController < ApplicationController
  before_action :get_scheme
  before_action :get_issue

  def create
    @comment = @issue.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to scheme_issue_path(@scheme, @issue)
  end

  private

  def get_scheme
    @scheme = Scheme.find(params[:scheme_id])
  end

  def get_issue
    @issue = @scheme.issues.find(params[:issue_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
