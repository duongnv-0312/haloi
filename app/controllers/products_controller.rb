class ProductsController < ApplicationController
  before_action :load_products, only: :index
  before_action :product, only: :show

  def index
  end

  def show
  end

  private

  def load_products
    @products = Product.all
  end

  def product
    @product = Product.find_by params[:id]
  end
end
