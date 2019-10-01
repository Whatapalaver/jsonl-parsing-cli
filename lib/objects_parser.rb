class ObjectsParser
  require 'json'
  require 'active_support/core_ext/hash/indifferent_access'

  attr_reader :data_path, :output_file, :method

  def initialize(opts = { json_folder_path: 'process_data', output_file_path: 'output.txt', specific_process: 'extract_unique_id' })
    puts 'intialised'
    @data_path = opts[:json_folder_path]
    @output_file = opts[:output_file_path]
    @method = opts[:specific_process].to_sym
  end

  def folder_parse
    # create the output text file or delete contents of existing file
    File.open(output_file, 'w') {}
    Dir.each_child(data_path) do |f|
      file = File.join(data_path, f)
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
end
