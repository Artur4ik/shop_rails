# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module Products
        extend ActiveSupport::Concern

        class ProductCategoryNotFound < ActiveRecord::RecordNotFound; end
        class ProductNotFound < ActiveRecord::RecordNotFound; end

        included do
          before_action :find_product_category, :find_products
          before_action :find_product, only: %i[show] # rubocop:disable Rails/LexicallyScopedActionFilter

          rescue_from ProductCategoryNotFound do
            render_errors(raw_product_category_not_found_error, :not_found)
          end

          rescue_from ProductNotFound do
            render_errors(raw_product_not_found_error, :not_found)
          end

          def find_product_category
            @product_category = ProductCategory.find_by(id: product_category_id)

            raise ProductCategoryNotFound unless @product_category
          end

          def find_products
            @products = @product_category.products
          end

          def find_product
            @product = @products.find_by(id: product_id)

            raise ProductNotFound unless @product
          end

          def product_category_id
            params[:product_category_id]
          end

          def product_id
            params[:id]
          end

          def raw_product_not_found_error
            I18n.t('errors.product.not_found', product_id:, product_category_id:)
          end

          def raw_product_category_not_found_error
            I18n.t('errors.product_category.not_found', product_category_id:)
          end
        end
      end
    end
  end
end
