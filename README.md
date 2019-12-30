<p align="left">
  <img width="370" src="https://user-images.githubusercontent.com/681278/71585040-1f6c9380-2b0d-11ea-90f4-68f03d37685a.jpg">
</p>

# Description

The purpose of this library is to provide simpler ways for manipulating table and its contents in Google Docs.

This solve for the difficulty myself and [a few others](https://github.com/tanaikech/node-gdoctableapp) had when attempting to manage tables on Google Docs using the Google Docs V1 API. 

## Features

- Create table with values in rows and columns

## Some Missing Features

- Read table values
- Update table values
- Delete tables, rows and columns

## Language Support

There are more fleshed out libraries in other languages that I found helpful when researching prior to deciding to build the first piece of the puzzle for Ruby.

- [go-gdoctableapp](https://github.com/tanaikech/go-gdoctableapp)
- [node-gdoctableapp](https://github.com/tanaikech/node-gdoctableapp)
- [gdoctableapppy](https://github.com/tanaikech/gdoctableapppy)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'google-docs-table-factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-docs-table-factory

## Usage

### Create table with values in rows and columns

```
requests = ::Google::Api::DocsV1::TableFactory.insert_table_request(
  index: 1,
  table_data: [
    ['A1', 'B1', 'C1'],
    [nil,  'B2',  nil],
    ['A3', 'B3', 'C3']
  ]
)
```

Will result in a structure GDocs V1 API can digest:
```
# => requests
[
  {:insert_table=>{:columns=>3, :rows=>3, :location=>{:index=>1}}}
  {:insert_text=>{:location=>{:index=>23}, :text=>"C3"}}
  {:insert_text=>{:location=>{:index=>21}, :text=>"B3"}}
  {:insert_text=>{:location=>{:index=>19}, :text=>"A3"}}
  {:insert_text=>{:location=>{:index=>14}, :text=>"B2"}}
  {:insert_text=>{:location=>{:index=>9}, :text=>"C1"}}
  {:insert_text=>{:location=>{:index=>7}, :text=>"B1"}}
  {:insert_text=>{:location=>{:index=>5}, :text=>"A1"}}
]
```

And look like:
![](https://user-images.githubusercontent.com/681278/71565771-e0f1bd00-2aa9-11ea-963e-2f48733a8222.jpg)

A full example could be:

```
require 'google/apis/docs_v1'
require 'googleauth'

# Service Account authorization or whatever else you prefer
gdocs = ::Google::Apis::DocsV1::DocsService.new
gdoc_auth = ::Google::Auth::ServiceAccountCredentials.make_creds(scope: 'https://www.googleapis.com/auth/documents')
gdocs.authorization = gdoc_auth

# POST updates to Google Docs
file_id = 'ABC123-GoogleDocumentId-Here'
batch_request = Google::Apis::DocsV1::BatchUpdateDocumentRequest.new(requests: requests)
gdocs.batch_update_document(file_id, batch_request)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gumatias/google-docs-table-factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Google::Api::DocsV1::TableFactory project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gumatias/google-docs-table-factory/blob/master/CODE_OF_CONDUCT.md).
