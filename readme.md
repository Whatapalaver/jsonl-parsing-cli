# Ruby Command Line Parsing Tool

This is an illustrative solution for iterating through multiple files within a folder and processing each line with a specified method.

The key features covered will be:

- command line interface
- use of command line flags to control the parsing functionality
- iterating through lines in a file (in this case JSONL data)
- iterating through all files within a folder
- passing method names as arguments

## How to Run

- `git clone https://github.com/Whatapalaver/jsonl-parsing-cli.git`

## Manual Testing (irb)

- enter irb `irb`
- `require './lib/objects_parser.rb'`
- `test = ObjectsParser.new`
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
