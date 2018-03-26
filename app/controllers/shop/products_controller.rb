class Shop::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    attach_pictures if @product.save
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end

  def attach_pictures
    if params[:images]
      params[:images].each do |image|
        @product.pictures.create(image: image)
      end
    end
  end
end
