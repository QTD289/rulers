require 'rulers/version'

module Rulers
  class Application
    def call(_env)
      [200, { 'Content-Type' => 'text/html' }, ['Hello from Ruby on Rulers!']]
    end
  end
end
