require 'spec_helper'

describe ObjectsParser do
  before :all do
    file_path = '../../example_data/extract_1.jsonl'
    @objects_parser = ObjectsParser.new(
      files: [file_path],
      output_file_path: 'example',
      method: 'cat'
    )
  end

  it 'has files' do
    expect(@objects_parser.files.length).to be 1
  end

  it 'can shoould respond to parse_files' do
    expect(@objects_parser).to respond_to(:parse_files)
  end
end
