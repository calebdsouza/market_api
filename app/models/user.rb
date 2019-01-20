class User < ApplicationRecord
    has_secure_password
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, length: { minimum: 5 }
    
    has_one :user
end