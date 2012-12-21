module ActiveAdminImportable
  module Importer
    class CSV

      def self.parse file
        require 'csv'

        csv = ::CSV.parse file.read
        header = csv.shift

        csv.select!{ |line| line.size == header.size }

        {header: header, data: csv}
      end

    end
  end
end