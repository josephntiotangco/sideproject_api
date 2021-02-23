class AppCounter < ApplicationRecord
    self.table_name = "appcounter"
    self.primary_key = "name"

    def AppCounter.get(name)
        counter = AppCounter.where(:name => name).first
        if(counter)
            counter.update(value: counter.value + 1)
            counter.value - 1
            return counter.value
        else
            counter = AppCounter.create :name => name, :value => 1
            return 1
        end
    end

    def AppCounter.roll_back_app_counter(name)
        counter = AppCounter.where(:name => name).first
        counter.update(value: counter.value - 1)
        return counter.value
    end
end