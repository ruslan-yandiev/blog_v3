class Admin::AdminController < ApplicationController
  # Устанавливаем на все экшены контролера Posts накладывается ограничение пока пользователь не будет зарегестрирован, (но оставим незарегистрированным спостреть данные вывадимые через методы index и show -> через вьюхи направит (изменил его))
  before_action :authenticate_user! # метод класса добавляющий специальный метод экземпляра (возможно приватный) имеющийся в геме devise который умолчанию вызывается во всех экшенах 
  before_action :check_admin

  layout "admin" # чтобы использовать свой layout с названием admin.html.erb во вьюхах в папке layouts

  protected

  def check_admin
  	redirect_to root_path, alert: 'У вас нет прав доступа к данной странице' unless current_user.admin?
  end
end