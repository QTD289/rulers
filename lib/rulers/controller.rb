require 'erubi'

module Rulers
  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name, locals = {})
      filename = File.join('app', 'views', controller_name, "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubi::Engine.new(template)
      locals.merge(env: env)
      vars = ''
      locals.each_pair { |k, v| vars += "#{k}='#{v}';" }

      eval vars + eruby.src
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore klass
    end
  end
end
