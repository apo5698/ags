# frozen_string_literal: true

module Rubrics
  module Criterion
    class Execute < Base
      def validate
        award_if @grade_item.stderr.empty? && @grade_item.error.empty?
      end
    end
  end
end
