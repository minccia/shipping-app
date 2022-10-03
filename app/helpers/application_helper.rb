module ApplicationHelper
  def formatted_zip_code(zip_code)
    "#{zip_code[0..4]}-#{zip_code[5..8]}"
  end    
end
