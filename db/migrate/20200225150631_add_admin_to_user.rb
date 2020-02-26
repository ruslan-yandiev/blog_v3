class AddAdminToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false #добавим в таблицу users поле(атрибут, колонку) admin с типом данных булевое значение и дефолтной настройкой фолс.
  end
end
