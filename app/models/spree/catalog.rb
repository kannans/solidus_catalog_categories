class Spree::Catalog < Spree::Taxon
  belongs_to :category, foreign_key: :taxonomy_id, class_name: 'Spree::Category', inverse_of: :catalogs
end
