require 'json'
module LambdaFunction
  class Handler
    def self.process(event:,context:)
      { event: JSON.generate(event), context: JSON.generate(context.inspect) }
    end
  end
end
