# Define a new GraphQL type, Query
Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :allProducts, !types[Types::ProductType] do
    description "Resolve all products in this database"
    resolve -> (obj, args, ctx) {
      Product.all
    }
  end

  field :allUsers, !types[Types::UserType] do
    description "Resolve all users in this database"
    resolve -> (obj, args, ctx) {
      User.all
    }
  end

  field :currentUser, Types::UserType do
    description "Resovle the current signed in user from this database"
    resolve -> (obj, args, ctx) {
      User.find_by(ctx[:current_user])
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
