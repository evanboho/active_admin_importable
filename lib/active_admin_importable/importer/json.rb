module ActiveAdminImportable
  module Importer
    class JSON

      def self.parse file

        json = JSON.decode file.read

        binding.pry

      end

    end
  end
end