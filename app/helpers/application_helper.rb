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
    "#{ collection.count } #{ vehicles } " + (collection.count == 1 ? t('found.singular') : t('found.plural'))
  end

end
