# frozen_string_literal: true

module Users
  module Commands
    class Base
      include ActiveModel::Validations

      def success?
        errors.empty?
      end

      def fail?
        !success?
      end

      def call
        raise NotImplementedError
      end
    end
  end
end
