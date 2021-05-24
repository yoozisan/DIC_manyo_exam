class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.order(expired_at: :desc)
    elsif params[:search]
      if params[:search_title].present? && params[:status_name].present?
        @tasks = Task.where("title LIKE ?", "%#{params[:search_title]}%").where(status_name: params[:search_status])
      elsif params[:search_title].present?  && params[:search_status].blank?
        @tasks = Task.where("title LIKE ?", "%#{params[:search_title]}%")
      elsif params[:search_title].blank? && params[:search_status].present?
        @tasks = Task.where(status_name: params[:search_status])
      else
        @tasks = Task.order(created_at: :desc)
      end
    else
      @tasks = Task.order(created_at: :desc)
    end
  end

  def show
  end

  def edit
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
	    render :new
		else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました！"
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
  	redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status_name)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
