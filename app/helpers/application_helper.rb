module ApplicationHelper
  def formatted_zip_code(zip_code)
    "#{zip_code[0..4]}-#{zip_code[5..8]}"
  end 

  def check_if_has_minimum(attribute)
    return I18n.translate('no_minimum') if attribute.nil?
    attribute
  end

  def found_vehicles_message(collection)
    if collection.length == 1 
      return "1 #{ Vehicle.model_name.human} #{ t 'found.singular' }"
    end
    return "#{ collection.count } #{ t 'activerecord.models.vehicle.many'} #{ t 'found.plural' }"
  end

end
