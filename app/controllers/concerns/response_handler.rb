module ResponseHandler

  extend ActiveSupport::Concern

  def error_handler(object, status = :unprocessable_entity)
    render(
      json: {
        message: Rack::Utils::HTTP_STATUS_CODES[400],
        data: nil,
        errors: object
      },
      status: status
    )
  end

  def success_handler(object, serializer = nil, view = :base, status = :ok, paginate = false)
    json_obj = {
      message: Rack::Utils::HTTP_STATUS_CODES[200],
      data: object,
      errors: nil
    }
    render(
      json: json_obj,
      status: status
    )
  end
end