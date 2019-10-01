require 'optparse'
require 'pp'
require_relative 'objects_parser.rb'

# present user with the help output if they forget to pass arguments 
# - only relevant if we have mandatory arguments
# ARGV << '-h' if ARGV.empty?

class OptionParser
  def self.parse(args)
    options = {
      json_folder_path: 'process_data',
      output_file_path: 'output.txt',
      method: 'extract_unique_id'
    }

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: options.rb [options]'
      opts.separator ''
      opts.separator 'Specific options:'

      # Mandatory argument
      # opts.on('-u', '--url REQUIRED URL', 'The file path to the NDJSON file') do |json_file_path|
      #   options[:json_file_path] << json_file_path
      # end

      # Optional arguments
      opts.on('-o', '--output OUTPUT PATH', 'Default is output.txt') do |output_file_path|
        options[:output_file_path] = output_file_path
      end

      opts.on('-f', '--folder DATA FOLDER PATH', 'Default is process_data') do |json_folder_path|
        options[:json_folder_path] = json_folder_path
      end

      opts.on('-s', '--method SPECIFIC METHOD NAME', 'Run process specific named method') do |method|
        options[:method] = method
      end
    end

    opt_parser.parse!(args)
    options
  end
end
