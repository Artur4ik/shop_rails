# frozen_string_literal: true

module Api
  module V1
    class ProductsController < BaseController
      include Api::V1::Concerns::Products

      def index
        render json: { items: @products, product_category: @product_category },
               each_serializer: ProductSerializer,
               status: :ok
      end

      def show
        render json: @product,
               serializer: ProductSerializer,
               status: :ok
      end
    end
  end
end
