require 'hocsv'
require 'tempfile'


RSpec.describe Hocsv, type: Class do
  describe "Hocsv" do
    it "has a version number" do
      expect(Hocsv::VERSION).not_to be nil
    end

    it "is a sub class of Object" do
      h = Hocsv
      expect(h.superclass).to be_a(Object)
    end
  end

  describe "#initialize" do
    before(:each) do
      file = Tempfile.new(['example', '.csv'])
      file_path_as_string = File.path(file)
      @hocsv = Hocsv.new([{one:1}], file_path_as_string)
    end

    it "creates a new Hocsv instance" do
      expect(@hocsv).to_not be_nil
    end
    it "responds to :data" do
      expect(@hocsv).to respond_to(:data)
    end

    it "responds to :filename" do
      expect(@hocsv).to respond_to(:filename)
    end

# :data
    context "validate :data" do
      it "is not nil?" do
        expect(@hocsv.data.nil?).to be(FALSE)
      end

      it "returns an Array object" do
        expect(@hocsv.data).to be_a(Array)
      end

      it "should not be empty" do
        expect(@hocsv.data.empty?).to be(FALSE)
      end

      it "should have at least one hash" do
        expect(@hocsv.data.any? {|element| element.is_a?(Hash)}).to be(true)
      end
    end
# :filename
    context "validate :filename" do
      it "is not nil?" do
        expect(@hocsv.filename.nil?).to be(FALSE)
      end

      it "returns a String object" do
        expect(@hocsv.filename).to be_a(String)
      end

      it "should not be empty" do
        expect(@hocsv.filename.empty?).to be(FALSE)
      end
    #forces extension on filename and converts path to string
    fileb = Tempfile.new(['example', '.csv'])
    fileb_path_as_string = File.path(fileb)
    let(:hocsv) {Hocsv.new([{one:1}, {two:2}], fileb_path_as_string)}

    context "it creates a new csv file" do
      # begin
        it "exists?" do
          expect(File.exist?(fileb)).to be(TRUE)
        end

        it "returns the correct filename" do
          expect(hocsv.filename).to eql(fileb_path_as_string)
        end

        it "has the correct basename" do
          expect(hocsv.filename).to include('example')
        end

        it "ends with .csv extension" do
          expect(File.extname(hocsv.filename)).to eql('.csv')
        end
      end
    # Error Testing
      describe "Errors" do
        let(:noary) { Hocsv.new({one:1},'file1') }
        let(:emptyary) { Hocsv.new([], 'file2') }
        let(:nohash) { Hocsv.new([true, 11, []], 'file3') }
        let(:emptyfile) { Hocsv.new([{two:2}], '') }
        let(:notastring) { Hocsv.new([{three:3}], true)}

        it "raises" do
          begin
            aggregate_failures "testing error responses" do
              expect{noary.data}.to raise_error(InvalidDataError, "Invalid data or file name. Please try again.")
              expect{emptyary.data.fetch(0)}.to raise_error(InvalidDataError, "Invalid data or file name. Please try again.")
              expect{nohash.data}.to raise_error(InvalidDataError, "Invalid data or file name. Please try again.")
              expect {emptyfile.filename}.to raise_error(InvalidDataError, "Invalid data or file name. Please try again.")
              expect {notastring.filename}.to raise_error(InvalidDataError, "Invalid data or file name. Please try again.")
            end
          end
        end
      end
    end
  end
end
