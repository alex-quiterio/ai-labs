# frozen_string_literal: true

require 'http'
require 'json'

module LLM
  # Abstract base class for LLM interactions
  module Clients
    # Custom error classes for better error handling
    class ApiError < StandardError; end
    class AuthenticationError < ApiError; end
    class RateLimitError < ApiError; end

    class Base
      def initialize(base_url:)
        @api_key = nil
        @base_url = base_url
      end

      def generate(_prompt)
        raise NotImplementedError, 'Subclasses must implement #generate'
      end

      protected

      def make_request(endpoint:, payload:)
        extra_headers = { 'Authorization' => "Bearer #{@api_key}" } if @api_key

        HTTP.headers(
          {'Content-Type' => 'application/json'}.merge(extra_headers || {})
        ).post("#{@base_url}#{endpoint}", json: payload)
      end
    end

  end
end
