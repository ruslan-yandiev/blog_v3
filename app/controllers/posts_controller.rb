class PostsController < ApplicationController
  # будет перед каждым экшином(методом) вызывать метод set_post, и ограничим за одно, чтобы вызывался только перед перечисленными методами
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = Post.new(post_params)
    if @post.save # если сохранение валидно, успешно то
      redirect_to @post, success: 'Статья успешно создана' # направляем на отображение объекта
    else # во всех остальных случаях
      render :new, danger: 'Статья не создана' # направить и отобразить форму new
    end
  end

  def edit; end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, success: 'Статья успешно обновлена'
    else
      render :edit, danger: 'Статья не обновлена'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, success: 'Статья удалена' # направим на вывод всех статей после удаления
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # приватный метод передающийся в аргументом в другой метод для фильтрации вводимых данных на уровне контроллера
  def post_params
    # означает, что в параметрах должен присутствовать только пост которому разрешаем только следующие поля totle, summary, body
    params.require(:post).permit(:title, :summary, :body, :image, :all_tags)
  end
end
