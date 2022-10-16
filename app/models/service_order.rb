class ServiceOrder < ApplicationRecord
  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at"]
  VALIDATABLE_ATTRS = ServiceOrder.attribute_names.reject{ |attr| NON_VALIDATABLE_ATTRS.include?(attr) }

  has_one :started, class_name: 'StartedServiceOrder', dependent: :nullify
  before_validation :generate_random_package_code
  validates_presence_of VALIDATABLE_ATTRS
  enum :status, { pending: 0, in_progress: 1, finished: 2 }

  def name_and_code
    "#{ ServiceOrder.model_name.human } <#{ self.package_code }>"
  end

  def formatted_dimensions
    "#{ self.package_height } x #{ self.package_width } x #{ self.package_depth }"
  end

  private 

    def generate_random_package_code
      self.package_code = SecureRandom.alphanumeric(15).upcase
    end
end
