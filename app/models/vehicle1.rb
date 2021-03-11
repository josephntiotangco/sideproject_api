class Vehicle < ApplicationRecord
    self.table_name = "vehicle"
    self.primary_key = "id"

    def get_next_vehiclecode
        counter = "vehicleCount"
        vehicleCode = AppCounter.get(counter)
        return vehicleCode
    end
#private
    def assign_default_values
        self.id = get_next_vehiclecode
        self.vehicleCode = "V" + Date.current.to_formatted_s(:number) + "-" + self.id.to_s
        self.status = "A"
        self.seatingOccupied = 0
        self.updateDate = Date.current
    end

    def roll_back_app_counter
        counter = "vehicleCount"
        counterCount = AppCounter.roll_back_app_counter(counter)
        return counterCount
    end
end
