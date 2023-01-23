# frozen_string_literal: true

module Auth
  module Commands
    class Base
      def self.call(*args)
        new(*args).call
      end

      def success?
        errors.empty?
      end

      def errors
        @errors ||= ActiveModel::Errors.new(self)
      end

      def initialize(*args)
        raise NotImplementedError
      end

      def call
        run_command

        self
      end
    end
  end
end
