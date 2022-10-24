module Freight
  class Calculator
    def initialize(transport_modality, service_order)
      @transport_modality = transport_modality 
      @so = service_order 
    end

    def can_execute_service_order?
      return false unless table_has_entries?
      if @so.package_weight <= @transport_modality.maximum_weight
        if @so.distance <= @transport_modality.maximum_distance
          return true 
        end
      end
      return false 
    end

    def table_has_entries? 
      @transport_modality.tables.each do |table| 
        next if table.table_entries.any?
        return false 
      end
    end
  
    def calculate(entries, target)
      entries.each { |second_interval, value| return value if target <= second_interval }
    end

    def calculate_distance_price 
      distance_entries = @transport_modality.distance_price_table.table_entries.pluck(:second_interval, :value)
      calculate(distance_entries, @so.distance)
    end
  
    def calculate_weight_price 
      weight_entries = @transport_modality.weight_price_table.table_entries.pluck(:second_interval, :value)
      calculate(weight_entries, @so.package_weight) * @so.distance
    end

    def calculate_due_date
      due_dates = @transport_modality.freight_table.table_entries.pluck(:second_interval, :value)
      calculate(due_dates, @so.distance)
    end
  
    def total_freight_price
      @transport_modality.fee + self.calculate_distance_price + self.calculate_weight_price
    end
  end
end