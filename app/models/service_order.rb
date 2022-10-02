class ServiceOrder < ApplicationRecord
  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at"]
  VALIDATABLE_ATTRS = ServiceOrder.attribute_names.reject{ |attr| NON_VALIDATABLE_ATTRS.include?(attr) }

  before_validation :generate_random_code
  validates_presence_of VALIDATABLE_ATTRS

  private 

    def generate_random_code
      self.package_code = SecureRandom.alphanumeric(15).upcase
    end
end
