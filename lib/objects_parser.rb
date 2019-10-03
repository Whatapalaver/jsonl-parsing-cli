# frozen_string_literal: true

class ObjectsParser
  require 'json'
  require 'active_support/core_ext/hash/indifferent_access'

  attr_reader :files, :output_file, :method

  def initialize(opts = {})
    puts 'intialised'
    @files = opts[:files]
    @output_file = opts[:output_file_path]
    @method = opts[:method].to_sym
  end

  def parse_files
    return if files.nil?

    # create the output text file or delete contents of existing file
    File.open(output_file, 'w') {}

    files.each do |file|
      next unless File.file?(file)

      puts "parsing #{file}"
      send(method, file)
    end
  end

  private

  def extract_unique_id(file)
    open(output_file, 'a') do |f|
      File.foreach(file) do |line|
        begin
          museum_object = JSON.parse(line).with_indifferent_access
        rescue JSON::ParserError
          next
        end
        f << museum_object[:uniqueID]
        f << "\n"
      end
    end
  end

  def uninteresting_method(file)
    open(output_file, 'a') do |f|
      p 'You may want to amend this method so it does something interesting with the data'
      f << 'This is a jolly un-interesting method'
    end
  end
end
