require 'search_object/plugin/graphql'

class Resolvers::ProductsSearch
    # Include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # Define product seach starting point
    scope {Product.all}

    # Define return type
    type !types[Types::ProductType]

    # Define input type for filter
    ProductFilter = GraphQL::InputObjectType.define do
        name 'ProductFilter'

        argument :OR, -> {types[ProductFilter]}
        argument :title_contains, types.String
        argument :in_stock, types.Boolean

    end

    option :filter, type: ProductFilter, with: :apply_filter

    def apply_filter(scope, value)
        # Normalize filters from nested OR structure
        branches = normalize_filters(value).reduce {|a, b| a.or(b)}
        scope.merge branches
    end

    def normalize_filters(value, branches = [])
        # List corresponding filter to SQL conditions
        scope = Product.all
        scope = scope.where('title LIKE ?', "%#{value['title_contains']}%") if value['title_contains']
        scope = scope.where('inventory_count > 0') if value['in_stock']

        branches << scope
    
        # Continue to normalize down
        value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?
    
        branches
    end
end