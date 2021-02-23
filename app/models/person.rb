class Person < ApplicationRecord
    self.table_name = "person"
    self.primary_key = "id"

    def get_next_personcode
        counter = "peopleCount"
        personCode = AppCounter.get(counter)
        return personCode
    end
#private
    def assign_default_values_person
        self.id = get_next_personcode
        self.personCode = "P" + Date.current.to_formatted_s(:number) + "-" + self.id.to_s
        self.status = "A"
    end

    def roll_back_app_counter
        counter = "peopleCount"
        counterCount = AppCounter.roll_back_app_counter(counter)
        return counterCount
    end
end
