class Admin::PicturesController < ApplicationController
  def create
  	# сохранит нашу картинку перенесенную в редактор
  	@picture = Picture.new(image_params)
  	@picture.save

  	# возвращать будет данные в формате json с указанным url адресом
  	respond_to do |format|
  	  format.json { render :json => { url: @picture.image.url(:large), picture_id: @picture.id } }
  	end
  end

  # удаляем картинку по индексу и возвращаем ответ в формате json
  def destroy
  	picture = Picture.find(params[:id])
  	picture.destroy

  	respond_to do | format|
  	  format.json { render json: { status: :ok } }
  	end
  end

  private
  # проверям полученные данные, что они относятся к picture и image
  def image_params
  	params.require(:picture).permit(:image)
  end
end
