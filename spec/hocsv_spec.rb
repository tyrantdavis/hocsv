require 'hocsv'

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
      @hocsv = Hocsv.new([{one:1}], 'fakefile')
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
            expect{noary.data}.to raise_error(TypeError, "ERROR: Invalid data type. Expected an Array. Got a(n) #{noary.data.class} #{noary.data.inspect}")
            expect{emptyary.data}.to raise_error(ArgumentError "Error: Empty array. Expected at least one array item. Got #{emptyary.data.inspect}")
            expect{nohash.data}.to raise_error(KeyError, "Error: No hash present in your Array. Expected at least one hash. Got #{nohash.data.inspect}")
            expect {emptyfile.filename}.to raise_error(ArgumentError, "ERROR: Filename cannot be empty. Got #{emptyfile.filename.inspect} ")
            expect {notastring.filename}.to raise_error(TypeError, "ERROR: Invalid filename. Expected a String. Got a(n) #{notastring.filename.class}")
          end
        end
      end
    end
end
