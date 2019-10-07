# Ruby Command Line Parsing Tool

This is an illustrative solution for iterating through multiple files within a folder and processing each line with a specified method.

The key features covered will be:

- command line interface
- use of command line flags to control the parsing functionality
- iterating through lines in a file (in this case JSONL data)
- iterating through all files within a folder
- passing method names as arguments

## Hacktoberfest Update

This would be a great project for a junior Ruby developer to contribute to. I have started by creating a JSONL parser that can be controlled from the command line but it might be great to expand this to cover other file formats.

So far I've had some great contributions that have improved the parsing script so that you can specify the files or file format to work on.

The following tasks are still available to work on:

- [] Add rspec and start implementing automated tests
- [] Add the functionality to process other data formats eg csv
- [] Refactoring etc.

## How to Run

- `git clone https://github.com/Whatapalaver/jsonl-parsing-cli.git`
- Run the command line tool with the default options using `bin/parse process_data/*`

The folder or filename is required and can be entered in multiple ways eg: `process_data/extract_1.jsonl` or `` or `example_data/extract_{1,2}.jsonl` or `process_data/*.jsonl`

You can also control the outout options with the following flags appended.

- -o followed by path to a text file where the output will be saved. The file will be created if it doesn't already exist and will be overwritten if it does. The default is output.txt in the root of the project.
- -s followed by a method name, runs a specified method. This can be useful for debugging a specific method eg. `bin/parse  -s uninteresting_method -o interesting.txt`
- --help shows all these options in the terminal

## Example Output (thanks to @bombsimon)

```ruby
$ bin/parse **/*.jsonl -s extract_unique_id -o output.txt
Processing the data:
{:files=>
  ["example_data/extract_1.jsonl",
   "example_data/extract_2.jsonl",
   "process_data/extract_1.jsonl"],
 :output_file_path=>"output.txt",
 :method=>"extract_unique_id"}
intialised
parsing example_data/extract_1.jsonl
parsing example_data/extract_2.jsonl
parsing process_data/extract_1.jsonl
```

```ruby
$ bin/parse example_data/extract_1.jsonl process_data/extract_1.jsonl -s extract_unique_id -o output.txt
Processing the data:
{:files=>["example_data/extract_1.jsonl", "process_data/extract_1.jsonl"],
 :output_file_path=>"output.txt",
 :method=>"extract_unique_id"}
intialised
parsing example_data/extract_1.jsonl
parsing process_data/extract_1.jsonl
```

```ruby
$ bin/parse example_data/extract_{1,2}.jsonl -s extract_unique_id -o output.txt
Processing the data:
{:files=>["example_data/extract_1.jsonl", "example_data/extract_2.jsonl"],
 :output_file_path=>"output.txt",
 :method=>"extract_unique_id"}
intialised
parsing example_data/extract_1.jsonl
parsing example_data/extract_2.jsonl
```

## Manual Testing (irb)

- enter irb `irb`
- `require './lib/objects_parser.rb'`
- `test = ObjectsParser.new({:files => 'process_data/*', :output_file_path => 'test.txt', :method => 'uninteresting_method'})`
- `test.folder_parse`

This should then generate a text file called 'output.txt' with all the unique id's from each line of data from the files located in the process_data folder.

## Illustrative Data

The example_data folder contains two files each with around 5000 object records form the V&A public collections site. They are in the JSONL format. I have included a single method that extracts the unique id from each record but you could create your own methods which could do things like:

- extracting image urls
- extracting data by specific artists

You may wish to refer to the [V&A api documentation](https://www.vam.ac.uk/api) to understand what the records contain and how to build image urls.

## Useful Links

- [options-parser](https://docs.ruby-lang.org/en/2.3.0/OptionParser.html)
- [Official JSONLines](http://jsonlines.org/)
- [JSONL vs JSON](https://hackernoon.com/json-lines-format-76353b4e588d)
- [Using the Command Line to run Ruby scripts](https://www.thoughtco.com/using-the-command-line-2908368)
- [Mandatory arguments without flag in optparse](https://stackoverflow.com/questions/2449171/how-to-parse-an-argument-without-a-name-with-rubys-optparse)
