# frozen_string_literal: true

module Rubrics
  module Criterion
    # Rubric criterion
    class Base < ApplicationRecord
      self.table_name = :rubric_criteria

      attr_accessor :grade_item

      #############
      # Constants #
      #############

      VARIABLES = {
        filename: 'Filename of the current rubric',
        actual: 'Actual file name',
        output: 'stdout and stderr',
        exitstatus: 'Process exit status code',
        error: 'Error count'
      }.freeze

      ################
      # Enumerations #
      ################

      enum action: {
        award: 'Award',
        award_each: 'Award / ea.',
        deduct: 'Deduct',
        deduct_each: 'Deduct / ea.'
      }

      ################
      # Associations #
      ################

      # noinspection RailsParamDefResolve
      belongs_to :item, class_name: 'Rubrics::Item::Base', foreign_key: :rubric_item_id, inverse_of: :criteria

      #############
      # Callbacks #
      #############

      # Initialize feedback
      after_initialize do
        self.feedback = default_feedback
      end

      ###############
      # Delegations #
      ###############

      %i[criteria i18n_key default_criterion default_feedback].each do |method|
        delegate method, to: :class
      end

      class << self
        # Returns all pre-defined rubric criteria. For example:
        #
        #   {
        #      "Rubrics::Criterion::Checkstyle"=>"%{filename} passes checkstyle",
        #      "Rubrics::Criterion::Classname"=>"Class is named %{filename}"
        #   }
        #
        # @return [Hash] all rubric criteria
        def criteria
          # noinspection RailsI18nInspection
          I18n.t('rubrics.criterion.criterion').transform_keys do |k|
            "#{name.deconstantize}::#{k.to_s.camelize}"
          end
        end

        # Returns the original key used in I18n translations. For example:
        #
        #   Rubrics::Criterion::Checkstyle.i18n_key(:feedback)
        #     #=> "checkstyle"
        #
        #   Rubrics::Criterion::MaximumPoint.i18n_original(:criterion)
        #     #=> "maximum_point"
        #
        # @param [Symbol] type value type
        # @return [String] key
        def i18n_key(type)
          ['rubrics', 'criterion', type, model_name.element].join('.')
        end

        # Returns the description for a type of rubric criterion, replaced variables by actual values.
        # (Defined in "config/locales/rubrics.en.yml")
        #
        # @param [Hash] reps replacements
        def default_criterion(**reps)
          Helli::String.replace(I18n.t(i18n_key(:criterion)), reps)
        end

        # Returns the feedback for a type of rubric criterion, replaced variables by actual values.
        # (Defined in "config/locales/rubrics.en.yml")
        #
        # @param [Hash] reps replacements
        def default_feedback(**reps)
          Helli::String.replace(I18n.t(i18n_key(:feedback)), reps)
        end
      end

      # @return [String] actual feedback
      def validate; end

      # Awards point to the associated grade item. Does not return the feedback.
      #
      # @param [Integer, nil] for_each awards point for each thing, such as @grade_item.error
      def award_point(for_each: nil)
        @grade_item.point += point * (for_each || 1)
        nil
      end

      # Deducts point to the associated grade item and returns the feedback.
      #
      # @param [Integer, nil] for_each awards point for each thing, such as @grade_item.error
      # @param [String] with custom feedback
      # @return [String] feedback string
      def deduct_point(for_each: nil, with: feedback)
        @grade_item.status = :error
        @grade_item.point -= point * (for_each || 1)
        "#{default_criterion}: #{with}"
      end

      # Sets the status to error and returns the feedback.
      #
      # @param [String] with custom feedback
      # @return [String] feedback string
      def error!(with: feedback)
        @grade_item.status = :error
        "#{default_criterion}: #{with}"
      end

      # Awards point to the associated grade item if the condition is met.
      # Otherwise returns the feedback only, no points will be awarded or deducted.
      #
      # @param [Boolean] condition condition to determine award point or not
      # @param [Integer] for_each awards point for each thing, such as @grade_item.error
      # @param [String] otherwise custom feedback, if any
      # @return [String, nil] feedback string if failed
      def award_if(condition, for_each: nil, otherwise: feedback)
        condition ? award_point(for_each: for_each) : error!(with: otherwise)
      end

      # Deducts point and return the failure feedback to the associated grade item if the condition
      # is met. Otherwise returns the feedback (default is 'Pass') only, no points will be awarded
      # or deducted.
      #
      # @param [Boolean] condition condition to determine deduct point or not
      # @param [Integer] for_each deducts point for each thing, such as @grade_item.error
      # @param [String] with feedback on success, default 'Pass'
      # @param [String] otherwise custom feedback, if any
      # @return [String] feedback string
      def deduct_if(condition, for_each: nil, with: feedback, otherwise: 'Pass')
        condition ? deduct_point(for_each: for_each, with: with) : error!(with: otherwise)
      end

      # @param [Array] reps replacements
      # @return [String] replaced feedback string
      def feedback_with(*reps)
        Helli::String.replace(feedback, reps)
      end
    end
  end
end

# See https://stackoverflow.com/a/16571498
unless Rails.env.production?
  (Dir["#{__dir__}/*.rb"] - [__FILE__]).each do |f|
    require_dependency f.delete_suffix('.rb')
  end
end
