class PostsController < ApplicationController
  # Устанавливаем на все экшены кроме index и show контролера Posts накладывается ограничение пока пользователь не будет зарегестрирован, но оставим незарегистрированным спостреть данные вывадимые через методы index и show -> через вьюхи направит
  before_action :authenticate_user!, except: %i[index show] # метод класса добавляющий специальный метод экземпляра (возможно приватный) имеющийся в геме devise который умолчанию вызывается во всех экшенах 

  # будет перед каждым экшином(методом) вызывать метод set_post, и ограничим за одно, чтобы вызывался только перед перечисленными методами
  before_action :set_post, only: %i[show edit update destroy] # технически он вызовет указанный метод в нутри экшена, реализация либо добавив туда при интерпритации кода, либо просто сначала вызовет просто этот метод перед экшенами и только затем метод-экшен запустит.

  def index
    # с помощью gem "will_paginate", укажем сколько постов отображать на странице
    @posts = Post.paginate(page: params[:page], per_page: 5)
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
      flash.now[:danger] = 'Статья не создана'
      render :new # направить и отобразить форму new
    end
  end

  def edit; end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, success: 'Статья успешно обновлена'
    else
      flash.now[:danger] = 'Статья не обновлена'
      render :edit
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
    params.require(:post).permit(:title, :summary, :body, :image, :all_tags, :category_id)
  end
end
