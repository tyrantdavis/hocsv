# Raises exceptions for invalid data types.
class InvalidDataError < StandardError
  # Instantiates when an invalid data error is raised.
  def initialize(response = "Invalid data or file name. Please try again.")
    # Invokes StandardError's initialize with a custom response.
    super(response)
  end
end
