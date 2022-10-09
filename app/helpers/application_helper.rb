module ApplicationHelper
  def formatted_zip_code(zip_code)
    "#{zip_code[0..4]}-#{zip_code[5..8]}"
  end 

  def check_if_has_minimum(attribute)
    return I18n.translate('no_minimum') if attribute.nil?
    attribute
  end
end
