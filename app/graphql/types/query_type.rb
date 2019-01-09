Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  field :allProducts, !types[Types::ProductType] do
    description "Resolve all products in this database"
    resolve -> (obj, args, ctx) {
      Product.all
    }
  end

  # TODO: remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end
end
