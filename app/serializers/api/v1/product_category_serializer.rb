# frozen_string_literal: true

module Api
  module V1
    class ProductCategorySerializer < ActiveModel::Serializer
      attributes :id, :name, :description
    end
  end
end
