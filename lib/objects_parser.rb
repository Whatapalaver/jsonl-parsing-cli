class ObjectsParser
  require 'json'
  require 'active_support/core_ext/hash/indifferent_access'

  attr_reader :data_path, :output_file, :method

  def initialize(opts = {})
    puts 'intialised'
    @data_path = opts[:json_folder_path]
    @output_file = opts[:output_file_path]
    @method = opts[:method].to_sym
  end

  def folder_parse
    # create the output text file or delete contents of existing file
    File.open(output_file, 'w') {}

    data_path.concat('/*') if File.directory?(data_path)

    Dir.glob(data_path).each do |f|
      file = File.join(f)
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
