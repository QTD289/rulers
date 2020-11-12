require 'rulers/version'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'

module Rulers
  class Application
    def call(env)
      return [404, { 'Content-Type' => 'text/html' }, []] if env['PATH_INFO'] == '/favicon.ico'

      begin
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        [200, { 'Content-Type' => 'text/html' }, [text]]
      rescue Exception => e
        [500, { 'Content-Type' => 'text/html' }, ["Error 500: #{e}"]]
      end
    end
  end
end
