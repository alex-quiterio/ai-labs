module LLM
  module Strategies
    class Conversation
      def initialize(model_client)
        @model_client = model_client
      end

      def respond_to(prompt)
        @model_client.generate(prompt)
      rescue LLM::Clients::ApiError => e
        handle_error(e)
      end

      private

      def handle_error(error)
        # Log error and implement retry logic if needed
        puts "Error occurred: #{error.message}"
        nil
      end
    end
  end
end
