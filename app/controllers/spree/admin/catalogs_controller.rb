module Spree
  module Admin
    class CatalogsController < Spree::Admin::BaseController
      respond_to :html, :json, :js
      def index
      end

      def search
        if params[:ids]
          @catalogs = Spree::Catalog.where(id: params[:ids].split(','))
        else
          @catalogs = Spree::Catalog.limit(20).ransack(name_cont: params[:q]).result
        end
      end

      def create
        @category = Category.find(params[:category_id])
        @catalog = @category.catalogs.build(params[:catalog])
        if @catalog.save
          respond_with(@catalog) do |format|
            format.json { render json: @catalog.to_json }
          end
        else
          flash[:error] = Spree.t('errors.messages.could_not_create_catalog')
          respond_with(@catalog) do |format|
            format.html { redirect_to @category ? edit_admin_category_url(@category) : admin_categories_url }
          end
        end
      end

      def edit
        @category = Category.find(params[:category_id])
        @catalog = @category.catalogs.find(params[:id])
        @permalink_part = @catalog.permalink.split("/").last
      end

      def update
        @category = Category.find(params[:category_id])
        @catalog = @category.catalogs.find(params[:id])
        parent_id = params[:catalog][:parent_id]
        new_position = params[:catalog][:position]

        if parent_id
          @catalog.parent = Catalog.find(parent_id.to_i)
        end

        if new_position
          @catalog.child_index = new_position.to_i
        end

        if params[:permalink_part]
          @catalog.permalink_part = params[:permalink_part].to_s
        end

        @catalog.assign_attributes(catalog_params)

        if @catalog.save
          flash[:success] = flash_message_for(@catalog, :successfully_updated)
        end

        respond_with(@catalog) do |format|
          format.html { redirect_to edit_admin_category_url(@category) }
        end
      end

      def destroy
        @catalog = Catalog.find(params[:id])
        @catalog.destroy
        respond_with(@catalog) { |format| format.json { render json: '' } }
      end

      private

      def catalog_params
        params.require(:catalog).permit(permitted_catalog_attributes)
      end
    end
  end
end
