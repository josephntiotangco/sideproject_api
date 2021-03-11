class Enduser < ApplicationRecord
    devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

    self.table_name = "enduser"
    self.primary_key = :id

    def get_next_enduser_code
        counter = "enduser_count"
        enduser_code = AppCounter.get(counter)
        return enduser_code
    end
#private
    def assign_default_values
        self.id = get_next_enduser_code
        self.end_user_code = "EU" + Date.current.to_formatted_s(:number) + "-" + self.id.to_s
        self.status = "D"
        self.email_confirmed = 0
        self.password_reset_count = 0
        self.password_invalid_count = 0
    end

    def roll_back_app_counter
        counter = "enduser_count"
        counter_count = AppCounter.roll_back_app_counter(counter)
        return counter_count
    end

end
