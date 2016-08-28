module Spree
  module Admin
    class CategoriesController < ResourceController
      private

      def location_after_save
        if @category.created_at == @category.updated_at
          edit_admin_category_url(@category)
        else
          admin_categories_url
        end
      end
    end
  end
end
