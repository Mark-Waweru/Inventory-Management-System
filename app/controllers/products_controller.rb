class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy purchase]
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to inventory_path, notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
    redirect_to inventory_path, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to inventory_path, notice: "Product deleted successfully"
  end

  def search
    if params[:query].present?
      @products = Product.search(params[:query])
    else
      @products = Product.all
    end

    # Respond to HTML and Turbo Stream formats
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def purchase
    if @product.quantity > 0
      @product.decrement!(:quantity)
      @message = "1 Product purchase successfully"
    else
      @message = "Product is out of stock"
    end

    respond_to do |format|
      format.html { redirect_to shop_path, notice: @message }
      format.turbo_stream
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
  params.require(:product).permit(
    :name,
    :price,
    :quantity,
    :product_image,
    :description
  )
  end
end
