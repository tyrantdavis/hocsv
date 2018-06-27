require 'bundler/setup'
require "hocsv/version"

class Hocsv

  attr_accessor :data, :filename

  def initialize(data, filename)
    self.data = validate_data(data)
    self.filename = validate_filename(filename)
  end


private
  def validate_data(data)
    raise(TypeError, "ERROR: Invalid data type. Expected an Array. Got a(n) #{data.class}.") unless data.class.eql?( Array )
    raise(ArgumentError, "Error: Empty array. Expected at least one array item.") unless !data.empty?
    raise(KeyError, "Error: No hash present in your Array. Expected at least one hash.") unless data.any? {|obj| obj.respond_to?(:keys)}
    data
  end

  def validate_filename(filename)
    raise(ArgumentError, "ERROR: Filename cannot be empty. Got #{filename.inspect}") unless !filename.empty?
    raise(TypeError, "ERROR: Invalid filename. Expected a String. Got a(n) #{filename.class}") unless filename.class.eql?( String )
    filename
  end
end
