class User < ApplicationRecord
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
    
  self.table_name = "user"
  self.primary_key = :user_id

end
