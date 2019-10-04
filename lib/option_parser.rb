require 'optparse'
require 'pp'
require_relative 'objects_parser.rb'

class OptionParser
  def self.parse(args)
    options = {
      files: ARGV,
      output_file_path: 'output.txt',
      method: 'extract_unique_id'
      # method: 'property_survey'
      # method: 'deep_key_search'
    }

    opt_parser = OptionParser.new do |opts|
      opts.banner = '*****************************************'
      opts.separator 'Usage: the folder or file path is required'
      opts.separator 'Minimal example: `bin/parse process_data/*`'
      opts.separator ''
      opts.separator 'Specific options:'

      # Optional arguments
      opts.on('-o', '--output OUTPUT PATH', 'Default is output.txt') do |output_file_path|
        options[:output_file_path] = output_file_path
      end

      opts.on('-s', '--method METHOD NAME', 'Run process specific named method') do |method|
        options[:method] = method
      end
    end

    opt_parser.parse!(args)

    # present user with the help output if they forget to pass arguments 
    # - only relevant if we have mandatory arguments
    if ARGV.empty?
      puts opt_parser
      exit(-1)
    end
    options
  end
end
