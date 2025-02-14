require_relative 'llm'

namespace :llm do
  namespace :llama do
    task :generate_response, [:prompt] do |t, args|
      client = LLM::Clients::Llama.new(
        model_version: '3',
      )

      response = LLM::Strategies::Conversation.new(client).respond_to(
        args[:prompt] || "Generate me a poem about nature"
      )

      puts response
    end
  end
end

task default: 'llm:llama:generate_response'
