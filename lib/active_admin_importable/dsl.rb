module ActiveAdminImportable
  module DSL

    def active_admin_importable
      action_item :only => :index do
        link_to "Import #{active_admin_config.resource_name.to_s.pluralize}", :action => 'import'
      end

      collection_action :import, :method => :get do
        render "admin/import"
      end

      collection_action :process_import, :method => :post do
        unless params[:import]
          flash[:alert] = "You should choose file for import"
          redirect_to :back
        end

        extension =
          case params[:import]['file'].content_type
            when 'text/csv'
              'csv'
            when 'application/json'
              'json'
            when 'text/xml'
              'xml'
          end

        unless extension.in? %w{csv json xml}
          flash[:alert] = "You can import file only with extension csv, json or xml"
          redirect_to :back
        end

        result = Importer.import extension, active_admin_config.resource_name, params[:import][:file]

        flash[:notice] = "Imported #{result[:imported]} #{active_admin_config.resource_name.downcase.send(result[:imported] == 1 ? 'to_s' : 'pluralize')}"
        redirect_to :back
      end

    end
  end
end