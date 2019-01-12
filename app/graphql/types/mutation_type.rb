# Defines new GraphQL Type, Mutation
Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  # Expose mutations created
  # Product Mutations
    # Create new Product
  field :createProduct, function: Mutations::CreateProduct.new
  # User Mutations
    # Create new User
  field :createUser, function: Mutation::CreateUser.new
    # Sign in User
  field :signinUser, function: Mutation::SignInUser.new
  
  # TODO: Remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end
end
