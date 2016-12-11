class ExperiencesController < ApplicationController
  before_action :get_post

  before_action :get_experience, only: [:edit, :update, :destroy, :show]

  def index
  	@experiences = Experience.all.where(:post_id => @post.id)
  end

  def new
  	@experience = Experience.new
  end

  def create
    puts "YYYYYYY"
  	@experience = Experience.new(experience_params)
    @experience.post_id = params[:post_id]
  	if @experience.save
  		decide_redirect
  	else
  		render "new"
  	end
  end

  def edit
  end

  def update
  	if @experience.update_attributes(experience_params)
      decide_redirect
  	else
  		render "edit"
  	end
  end

  def destroy
  	@experience.destroy
  	redirect_to "index"
  end

  private
  def get_post
  	@post = Post.find(params[:post_id])
  end

  def show
  end

  def get_experience
  	@experience = Experience.all.where(:post_id => @post.id).first
  end

  def experience_params
  	params.require(:experience).permit(:place, :position, :work_start, :work_end, :current_work, :post_id)
  end

  def decide_redirect
    if @post.projects.count > 0
      redirect_to edit_post_project_path(@post.id)
    else
      redirect_to new_post_project_path(@post.id)
    end    
  end
end
