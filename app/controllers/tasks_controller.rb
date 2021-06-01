class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page]).per(5)

    @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page]).per(5) if params[:sort_expired].present?
    @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(5) if params[:sort_priority].present?

    if params[:search]
      @tasks = @tasks.search_title(params[:search_title]) if params[:search_title].present?
      @tasks = @tasks.search_status(params[:search_status]) if params[:search_status].present?
      @tasks = @tasks.search_label(params[:search_label]) if params[:search_label].present?
    end

    # if params[:sort_expired]
    #   @tasks = Task.order(expired_at: :desc)
    #
    # elsif params[:sort_priority]
    #   @tasks = Task.order(priority: :desc)
    #
    # elsif params[:search]
    #   if params[:search_title].present? && params[:search_status].present?
    #     @tasks = Task.search_title(params[:search_title]).search_status(params[:search_status])
    #   elsif params[:search_title].present?
    #     @tasks = Task.search_title(params[:search_title])
    #   elsif params[:search_status].present?
    #     @tasks = Task.search_status(params[:search_status])
    #   else
    #     @tasks = Task.order(created_at: :desc)
    #   end
    # else
    #   @tasks = Task.order(created_at: :desc)
    # end
  end

  def show
  end

  def edit
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status_name, :priority, {label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
