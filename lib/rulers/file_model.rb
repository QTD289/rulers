require 'multi_json'
require 'json'

module Rulers
  module Model
    class FileModel
      attr_reader :hash

      def initialize(filename)
        @filename = filename
        # If filename is "dir/37.json", @id is 37
        basename = File.split(filename)[-1]
        @id = File.basename(basename, '.json').to_i
        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      class << self
        def find(id)
          FileModel.new("db/quotes/#{id}.json")
        rescue StandardError
          nil
        end

        def all
          files = Dir['db/quotes/*.json']
          files.map { |f| FileModel.new f }
        end

        def create(attrs)
          hash = {}
          attrs.each_pair { |k, v| hash[k] = v }

          id = highest_id + 1
          File.open("db/quotes/#{id}.json", 'w') do |f|
            f.write gen_template_from(hash)
          end
          FileModel.new "db/quotes/#{id}.json"
        end

        private

        def highest_id
          files = Dir['db/quotes/*.json']
          names = files.map { |f| f.split('/')[-1] }
          names.map { |b| b[0...-5].to_i }.max
        end

        def gen_template_from(hash)
          <<~TEMPLATE
            #{hash.to_json}
          TEMPLATE
        end
      end
    end
  end
end
