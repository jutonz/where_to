module WhereTo
  class NoFilesError < RuntimeError
    def initialize(extension, location)
      super("I couldn't find any files with the extension #{extension} in #{location}")
    end
  end
end
