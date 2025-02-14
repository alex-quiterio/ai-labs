# frozen_string_literal: true

module LLM
  module Clients
    class Llama < Base
      def initialize(model_version: '3', base_url: 'http://localhost:11434')
        super(
          base_url: base_url
        )
        @model_version = model_version
      end

      def generate(prompt, temperature: 0.9, max_tokens: 256)
        response = make_request(
          endpoint: '/api/generate',
          payload: {
            model: "llama#{@model_version}",
            prompt: prompt,
            top_p: 0.9,
            top_k: 40,
            temperature: temperature,
            max_tokens: max_tokens
          }
        )
        handle_response(response)
      end

      private

      def handle_response(response)
        case response.code
        when 200
          parse_successful_response(response.body)
        when 401
          raise AuthenticationError, 'Invalid API key'
        when 429
          raise RateLimitError, 'Rate limit exceeded'
        else
          raise ApiError, "Unexpected error: #{response.body}"
        end
      end

      def parse_successful_response(response_body)
        parsed_response = JSON.parse("[ #{response_body.to_a.join.split(/\n/).join(',')} ]")

        return parsed_response.map { |row| row['response'] }.join
      end
    end
  end
end
