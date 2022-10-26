module ApplicationHelper
  def formatted_zip_code(zip_code)
    "#{zip_code[0..4]}-#{zip_code[5..8]}"
  end 

  def check_if_has_minimum(attribute)
    return I18n.translate('no_minimum') if attribute.nil?
    attribute
  end

  def found_vehicles_message(collection)
    vehicles = Vehicle.model_name.human(count: collection.count)
    "#{ collection.count } #{ vehicles } #{ t(:found, count: collection.count) }"
  end

  def table_entry_hours_and_days(value)
    day_quantity = value/24
    "#{value.to_i} #{  t 'units.hours' } (#{day_quantity.to_i} #{ t 'units.days', count: day_quantity })"
  end

  def attending_transport_modalities(so)
    attending = []
    TransportModality.all.each do |trans_mod| 
      attending << trans_mod if trans_mod.can_execute_service_order?(so)
    end
    attending
  end

  def so_modality_selection(so, modalities)
    modalities.map do |trans| 
      price = number_to_currency(trans.so_execution_price(so))
      due_date = table_entry_hours_and_days(trans.so_execution_due_date(so))
      ["#{ trans.name} - #{ price } - #{ due_date }", trans.id]
    end
  end
end
