require 'bundler/setup'
require "hocsv/version"
require 'csv'
require 'hocsv/errors'

class Hocsv

  attr_accessor :data, :filename

  def initialize(data, filename="hocsv.csv")
    self.data = data
    self.filename = filename
    raise InvalidDataError.new if (!data.is_a?(ARRAY)) || (data.empty?.eql(True)) || (!data.any? {|obj| obj.respond_to?(:keys)}) || (!filename.class.eql?(String)) || (filename.empty?.eql(True))
  end

# Creates .csv file and converts data to csv
  def to_hocsv
    return puts "A file with that name already exists." if File.file?(filename)

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

    filename.close
  end

end
