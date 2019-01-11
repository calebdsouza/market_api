# Defines new GraphQL Type, Mutation
Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  # expose create Product mutation
  field :createProduct, function: Mutations::CreateProduct.new
  # TODO: Remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end
end
