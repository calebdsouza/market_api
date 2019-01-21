# E-Commerce Store API
![built with love](https://cloud.githubusercontent.com/assets/2231765/6766607/d07992c6-cfc9-11e4-813f-d9240714dd50.png)

This is an API which represents a basic e-commerce market.

## Verions
* Ruby 2.6.0
* Gem 3.0.1
* Rails 5.2.2
* SQLite 3.8.5
* GraphQL 1.7.4

## Install
Downlaod from Ruby from [here](https://www.ruby-lang.org/en/documentation/installation/)
```bash
gem install bundler
gem install rails -v 5.2.2
bundle update
rails: db:migrate
```

## Usage
First run server to start API
```bash
rails server
```

### Mutations
To access GraphQL API interface go [http://0.0.0.0:3000/graphiql](http://0.0.0.0:3000/graphiql)
* Create a new User
```graphql
mutation {
    createUser(
        name: "User's name",
    authProvider: {
        credentials: {
        email: "user@email.com",
        password: "password"
        }
    }
    ) {
        id
        name
        email
    }
}
```
* Sign in User
```graphql
mutation {
    signinUser(
        credentials: {
        email: "user@email.com"
        password: "password"
    }
    ) {
        user {
            id
            name
            email
        }
        token
    }
}
```
* Create a single Cart for a User

Note: 
    * User must be signed in to create a Cart.
    * A User can only have one Cart at a time.
```graphql
mutation {
    createCart(

    ) {
        user {
            id
            name
            email
        }
        products {
            id
            title
            price
            inventory_count
        }
        product_count
        total_price
    }
}
```

* Add a Product to the User's Cart
```graphql
mutation {
    addProductToCart(
        product_id: 1
        quantity: 1
    ) {
        id
        cost
        product_count
        cart {
            id
            user {
                id
                name
                email
            }
            products {
                id
                title
                price
                inventory_count   
            }
        }
    }
}
```

* Delete a Product from the User's Cart
```graphql
mutation {
  deleteProductFromCart(
		product_id: 1
		quantity: 1
  ) {
        id
        total_price
        product_count
        user {
            id
            name
            email
        }
        products {
            id
            title
            price
            inventory_count
        }
    }
}
```

* Checkout a User's Cart
```graphql
mutation {
  confirmCart(
		password: "password"
  ) {
        total_price
        status
        cart {
            id
            product_count
            total_price
            user {
                id
                name
                email
            }
            products {
                id
                title
                price
                inventory_count
            }
        }
    }
}
```

### Queries
* Get the current User
```graphql
query {
    currentUser(        
    ){
        id
        name
        email
    }
}
```
* Get all Users
```graphql
query {
    allUsers {
        id
        name
        email
    }
}
```
* Get all Products
```graphql
query {
    allProducts(
    ) {
        id
        title
        price
        inventory_count
    }
}
```
* Get all Products with a Product title constraint
```graphql
query {
    allProducts(
        filter: {
            title_contains: "Chocolate",
            OR: {
            title_contains: "Snacks"
            }    
        }
    ) {
        id
        title
        price
        inventory_count
    }
}
```
* Get all Products that are currently in stock
```graphql
query {
    allProducts(
        filter: {
            in_stock: true    
        }
    ) {
        id
        title
        price
        inventory_count
    }
}
```
* Get all Carts
```graphql
query {
    allCartsProducts {
        id
        cost
        quantity
        cart {
            id
            total_price
            product_count
            user {
                id
                name
                email
            }
            products {
                id
                title
                price
                inventory_count
            }
        }
        product {
            id
            title
            price
            inventory_count
        }
    }
}
```

* Get all Carts
```graphql
query {
    allCarts {
        id
        total_price
        product_count
        user {
            id
            name
            email
        }
        products {
            id
            title
            price
            inventory_count
        }
    }
}
```

## Testing
To run tests...
```bash
rake test
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.