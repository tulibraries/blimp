# Blimp
Short description and motivation.

## Usage
How to use this plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'blimp'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install blimp
```

Then migrate the blimp database
```bash
$ rake blimp:install:migrations 
$ rake db:migrate
```

The Solr URL is `http://localhost:8983/solr/blacklight-core`. To change the solr core, set the environment variable SOLR_URL.

To import a CSV file with headers, visit [http://0.0.0.0:3000/blimp/uploads], select the file to ingest and enter the header of the column with the unique ID.
Blimp will import the data when you submit the form.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
