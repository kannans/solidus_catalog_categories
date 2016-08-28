class Spree::Category < Spree::Taxonomy
  # has_many :catalogs, foreign_key: :taxonomy_id, class_name: "Spree::Catalog", inverse_of: :category
  # has_one :root, -> { where parent_id: nil }, foreign_key: :taxonomy_id, class_name: "Spree::Catalog", dependent: :destroy
end
