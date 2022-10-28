class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :internal_error_500
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_404

  private 

    def internal_error_500
      render status: 500 
    end

    def not_found_404
      render status: 404 
    end

    def parse_json(obj)
      obj.as_json(except: [:created_at, :updated_at])
    end
end