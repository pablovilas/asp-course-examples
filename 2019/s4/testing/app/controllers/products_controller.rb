class ProductsController < ApplicationController
    
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    
    def index
        @products = Product.all
        render json: @products
    end
    
    def show
        if @product then
            render json: @product
        else
            render_error 404, "Product #{params[:id]} Not found"
        end
    end
        
    def create
        @product = Product.new(product_params)
        begin
            @product.save!
            render json: @product, status: 201
        rescue StandardError => e
            render_error 500, e.message
        end
    end
    
    def update
        if @product then
            begin
                @product.update!(product_params)
                render json: @product
            rescue StandardError => e
                render_error 500, e.message
            end
        else
            render_error 404, "Product #{params[:id]} Not found"
        end
    end
    
    def destroy
        if @product then
            begin
                @product.destroy!
                render json: @product
            rescue StandardError => e
                render_error 500, e.message
            end
        else
            render_error 404, "Product #{params[:id]} Not found"
        end
    end

    private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        if Product.exists?(params[:id])
            @product = Product.find(params[:id])
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price)
    end
    
end
