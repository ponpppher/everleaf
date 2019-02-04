class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  def index
    @tasks = current_user.tasks.recent
  end

  def show;end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      # newのテンプレートと値を返しているが、
      # そのままだとifを抜けて下の処理にいってしまうため、returnが必要
      return render :new
    end
    
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit;end

  def confirm_new
    # taskが検証を通らなかった場合,新規画面を返す
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end


  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク#{@task.name}を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
