class ProductsController < ApplicationController
  before_action :product, only: :show

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
  end

  def show
  end

  private

  def load_products
    @products = Product.all
  end
end
