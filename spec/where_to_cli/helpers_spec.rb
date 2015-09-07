require 'spec_helper'

describe WhereToCLI::Helpers do

  describe ".check_location!" do
    it "returns . if no location is given" do
      expect(WhereToCLI::Helpers.check_location!(nil)).to eql '.'
    end

    it "raises if the location does not exist" do
      expect(File).to receive(:exist?).with('/some/location') { false }

      expect {
        WhereToCLI::Helpers.check_location!('/some/location')
      }.to raise_error "The location '/some/location' does not exist"
    end

    it "returns a valid location" do
      expect(File).to receive(:exist?).with('/some/location') { true }

      expect(WhereToCLI::Helpers.check_location!('/some/location'))
        .to eql '/some/location'
    end
  end
end
