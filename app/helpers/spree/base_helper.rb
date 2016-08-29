module Spree
  module BaseHelper
    def plural_resource_name(resource_class)
    end

    def admin_breadcrumbs
       @admin_breadcrumbs ||= []
    end

    def admin_breadcrumb(*ancestors, &block)
      admin_breadcrumbs.concat(ancestors) if ancestors.present?
      admin_breadcrumbs.push(capture(&block)) if block_given?
    end
  end
end
