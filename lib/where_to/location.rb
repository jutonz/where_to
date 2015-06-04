module WhereTo
  class Location # implements comparable
    attr_accessor :folder, :filename, :location

    def initialize(from_location)
      @location = from_location
      set_filename_folder_from_location
    end

    def ==(other)
      location == other
    end

    private

    def set_filename_folder_from_location
      split = location.split '/'
      last  = split[-1]
      if File.extname(last) == '' # No extension; is a directory
        @folder   = location
        @filename = ''
      else
        @filename = split.pop
        @folder   = split.join '/'
      end
    end 

  end
end