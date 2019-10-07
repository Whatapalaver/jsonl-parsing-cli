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

  # Top-level properties found in jsonl file, with number of occurrences
  def property_survey(file)
    h = {}
    File.foreach(file) do |line|
      begin
        object = JSON.parse(line).with_indifferent_access
      rescue JSON::ParserError
        next
      end
      object.keys.each do |k|
        h[k] ? h[k] += 1 : h[k] = 1
      end
    end
    open(output_file, 'a') do |f|
      h.each do |k, v|
        f << "#{k}: #{v}\n"
      end
    end
  end

  # Sorted list of all keys found at any depth in jsonl file
  def deep_key_search(file)
    keys = []
    File.foreach(file) do |line|
      begin
        object = JSON.parse(line).with_indifferent_access
        keys |= object.deep_keys
      rescue JSON::ParserError
        next
      end
    end
    open(output_file, 'a') do |f|
      f << keys.sort.join("\n")
    end
  end
end

# Monkey patch
class Hash
  # Extract all objects used as keys at any depth of hash
  def deep_keys
    keys | values.select{|k| k.kind_of? Hash}.map(&:deep_keys).flatten
  end
end
