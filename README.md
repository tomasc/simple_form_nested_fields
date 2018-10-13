# Simple Form Nested Fields

[![Build Status](https://travis-ci.org/tomasc/simple_form_nested_fields.svg)](https://travis-ci.org/tomasc/simple_form_nested_fields) [![Gem Version](https://badge.fury.io/rb/simple_form_nested_fields.svg)](http://badge.fury.io/rb/simple_form_nested_fields) [![Coverage Status](https://img.shields.io/coveralls/tomasc/simple_form_nested_fields.svg)](https://coveralls.io/r/tomasc/simple_form_nested_fields)

Nested fields helper for [`simple_form`](https://github.com/plataformatec/simple_form).

Makes it easier to handle forms with referenced/embedded models and attributes;
e.g. a document with embedded texts, a project with referenced tasks, or an
invoice with line items.

Works with standard Rails forms and SimpleForm.

## Dependencies

This gem depends on jQuery.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_form_nested_fields'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_form_nested_fields

If using sprockets, require the javascript in your `application.js`:

```js
//= require simple_form_nested_fields
```

and initialise the plugin like this:

```js
$(document).ready(
  function() {
    $(".simple_form_nested_fields").SimpleFormNestedFields()
  }
)
```

## Usage

Suppose you have a model `MyDoc`, which embeds `texts`:

```ruby
# app/models/my_doc.rb
class MyDoc
  include Mongoid::Document
  embeds_many :texts, class_name: 'Text'
  accepts_nested_attributes_for :texts, allow_destroy: true
end

# app/models/text.rb
class Text
  include Mongoid::Document
  field :body, type: String
  embedded_in :my_doc, class_name: 'MyDoc'
end
```

You can then use the `nested_fields_for` helper to work with the texts in your
form:

```slim
= simple_form_for @my_doc do |f|
  = f.nested_fields_for :texts
  = f.submit
```

This will render the `texts/_fields` partial, in which you can use the `fields`
helper:

```slim
// app/views/my_docs/texts/_fields.html.slim
= fields.input :body
```

### Sortable

Making the nested fields sortable is straight forward.

Using our `MyDoc` and `texts` example, the models would look like this (note the
`order` on the `embeds_many` and the `position` field on the `Text`):

```ruby
# app/models/my_doc.rb
class MyDoc
  include Mongoid::Document
  embeds_many :texts, class_name: 'Text', order: :position.asc
  accepts_nested_attributes_for :texts, allow_destroy: true
end

# app/models/text.rb
class Text
  include Mongoid::Document
  field :body, type: String
  field :position, type: Integer
  embedded_in :my_doc, class_name: 'MyDoc'
end
```

Then in your `MyDoc` form simply pass the `sortable` option to the
`nested_fields_for` helper (note that in order to pass the option parameter, you
have to pass the second parameter: the collection/record object):

```slim
= simple_form_for @my_doc do |f|
  = f.nested_fields_for :texts, @my_doc.texts, sortable: true
  = f.submit
```

And in your `Text` fields partial add the position input:

```slim
// app/views/my_docs/texts/_fields.html.slim
= fields.input :position, as: :hidden
= fields.input :body
```

### Configuration

#### Custom partial path

You can override the default `_fields` partial lookup path as follows:

```slim
= simple_form_for @my_doc do |f|
  = f.nested_fields_for :texts, nil, partial: 'my/own/path/to/fields'
  = f.submit
```

#### I18n

* TODO

### Styling

TODO

## Todo

* Sortable field name should be configurable (`position` by default)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomasc/simple_form_nested_fields. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
