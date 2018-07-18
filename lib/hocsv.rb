require 'bundler/setup'
require "hocsv/version"
require 'csv'
require 'hocsv/errors'

# Converts an array of hashes into csv format and creates a csv file
class Hocsv

  # 'data' attribute takes data in the form of an array of hashses
  # 'filename' attribute takes a string as the name of the file to be created.
  attr_accessor :data, :filename

  # Creates an instance with data and filename attributes.
  # 'data' parameter recieves an array of hashses or a local variable storing an array of hashses.
  # 'filename' parameter recieves a string; defaults to 'hocsv.csv'
  # Invokes to_hocsv

  def initialize(data, filename="hocsv.csv")
    # 'data=' Returns the value of the data sent to the 'data' parameter
    self.data = data

    # Returns the value of the 'filename' parameter
    self.filename = filename
    raise InvalidDataError.new if (!data.is_a?(Array)) || (data.empty?.eql?(TRUE)) || (!data.any? {|obj| obj.respond_to?(:keys)}) || (!filename.is_a?(String)) || (filename.empty?.eql?(TRUE))
    to_hocsv
  end

  # Creates .csv file and converts data to csv
  def to_hocsv
    # adds. .csv to the end of the filename if not present
    filename.concat('.csv') if !filename.include?(".csv")

    #Places uniq keys into an array
    headers = data.flat_map(&:keys).uniq
    # Opens a new csv file in read and write mode with the provided file name or the default file name; adds column formatting
    CSV.open(filename, "w+b", col_sep: ', ') do |csv|

      # pushes headers to the file
      csv <<  headers

      data.each do |hash|
      #Retrieves values at a keys location, and inserts empty space when no value is present
        csv << hash.values_at(*headers)
      end
    end
  end
end
