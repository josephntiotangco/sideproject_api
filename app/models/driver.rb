class Driver < ApplicationRecord
    self.table_name = "driver"
    self.primary_key = "id"
    
    #before_validation :assign_default_values

    def get_next_drivercode
        counter = "driverCount"
        driverCode = AppCounter.get(counter)
        return driverCode
    end
#private
    def assign_default_values
        self.id = get_next_drivercode
        self.driverCode = "D" + Date.current.to_formatted_s(:number) + "-" + self.id.to_s
        self.status = "A"
    end

    def roll_back_app_counter
        counter = "driverCount"
        counterCount = AppCounter.roll_back_app_counter(counter)
        return counterCount
    end
end