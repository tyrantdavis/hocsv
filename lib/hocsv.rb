require 'bundler/setup'
require "hocsv/version"
require 'csv'
require 'hocsv/errors'

class Hocsv

  attr_accessor :data, :filename

  def initialize(data, filename="hocsv.csv")
    self.data = data
    self.filename = filename
    raise InvalidDataError.new if (!data.is_a?(Array)) || (data.empty?.eql?(TRUE)) || (!data.any? {|obj| obj.respond_to?(:keys)}) || (!filename.is_a?(String)) || (filename.empty?.eql?(TRUE))
    to_hocsv
  end

# Creates .csv file and converts data to csv
  def to_hocsv

    filename.concat('.csv') if !filename.include?(".csv")

    #Places uniq keys into an array
    headers = data.flat_map(&:keys).uniq
    CSV.open(filename, "w+b", col_sep: ', ') do |csv|
      csv <<  headers
      data.each do |hash|
        #Retrieves values at a keys location, and inserts empty space when no value is present
        csv << hash.values_at(*headers)
      end
    end
  end
end
