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

  field :allCarts, !types[Types::CartType] do
    description "Resovle all carts in this database"
    resolve -> (obj, args, ctx) {
      Cart.all
    }
  end

  field :allCartsProducts, !types[Types::CartsProductsType] do
    description "Resovle all products in a cart in this database"
    resolve -> (obj, args, ctx) {
      CartsProducts.all
    }
  end

  field :currentUser, !Types::UserType do
    description "Resovle the current signed in user from this database"
    resolve -> (obj, args, ctx) {
      ctx[:current_user]
    }
  end

end
