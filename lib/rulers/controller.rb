require 'erubi'
require 'rulers/file_model'
require 'pry'

module Rulers
  class Controller
    include Rulers::Model

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name, locals = {})
      filename = File.join('app', 'views', controller_name, "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubi::Engine.new(template)
      locals.merge(env: env)

      vars = assign_locals(locals)

      eval vars + eruby.src
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore klass
    end

    private

    def assign_locals(locals)
      ret = ''
      locals.each_pair do |k, v|
        ret += if v.instance_of?(FileModel)
                 "#{k}=#{v.hash};"
               else
                 "#{k}='#{v}';"
               end
      end
      ret
    end
  end
end
