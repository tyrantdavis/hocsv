class InvalidDataError < StandardError
  def initialize(response = "Invalid data or file name. Please try again.")
    super(response)
  end
end
