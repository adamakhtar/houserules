# Houserules

** WARNING **

**This is not finished so please do not expect it to work or any support in the issues yet.**

## What is it and why should you care


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'houserules', group: :test
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install houserules


## Useage

** (re)write your authorization specs in the following way**

RSpec.describe "Post:", houserule: true do
  context "when creating a post" do
    it "permits admin" do
        # ...
    end

    it "denies guest" do
        # ...
    end
  end

  context "when editing a post" do
    it "permits admin" do
        # ...
    end

    it "denies guest" do
        # ...
    end
  end
end
```

This results in spec descriptions like:

"Post: when creating a post permits admin"
"Post: when creating a post denies guest"

**Note** the keywords **when**, **denies** and **permits** are required.

** Setup a basic controller to view the rules table **
Set up a basic controller, index action and route to display your rules table PermissionsController#index.

```
class PermissionsController < ApplicationController
  def index
  end
end

# routes
get 'permissions' => 'permissions#index'
```

Now copy the template from this gem's `lib/templates/styled.html.erb` to `app/views/documentation/_permissions.html.erb`

** Configure Rspec **

In your_app/specs/spec_helper.rb add the following:

```
require 'houserules' # add this ...

RSpec.configure do |config|
  # ... and add this
  config.after(:suite) do
    html = Houserules.render(Rails.root.join("app", "views", "permissions", "_permissions.html.erb"))
    File.open(Rails.root.join("app", "views", "permissions", "index.html.erb"), "w"){|f| f.write html }
    Houserules.clear
  end
end
```

** Run the specs **

`rake`

** Now view your permissions table at localhost:blah/permissions **


## Usage in detail

Houserules expects you to write your specs a certain way so that it can parse them into the final table. A typical spec file would look like this:

```ruby
RSpec.describe "Post:", houserule: true do
  context "when creating a post" do
    it "permits admin" do
        # ...
    end

    it "denies guest" do
        # ...
    end
  end

  context "when editing a post" do
    it "permits admin" do
        # ...
    end

    it "denies guest" do
        # ...
    end
  end
end
```

`RSpec.describe "Post:", houserule: true do`

Here "Post:" describes the resource being accessed. The colon is optional.

`context "when creating a post" do`

Everything after the keyword "when" is considered to be the action.

`it "permits admin" do`

"permits" (or "denies") denote the ability to perform the action.

Everything past the keywords "permits" and "denies" is parsed as the actor who performs the action e.g. admin

**Adding contextual notes**

Sometimes you might want to add a little note about a specific actor's ability to do a specific action. For example a user can only leave a product rating if they have confirmed their phone number.
You can do that by writing the note in brackets like so:

```ruby
RSpec.describe "Review:", houserule: true do
  context "when creating a review" do
    it "permits user (phonenumber must be confirmed)" do
        # ...
    end
  end
end
```

This is then parsed and provided to you to use when creating the visual table.
`
## The rules graph

After parsing your spec descriptions Houserules creates a nested hash structure. A spec file that looks like this ...

```ruby
RSpec.describe "Post:", houserule: true do
  context "when creating a post" do
    it "permits admin" do
        # ...
    end

    it "denies guest" do
        # ...
    end
  end

  context "when editing a post" do
    # etc
  end
end
```

... which creates a rules graph that looks like this ...

```ruby
{
  "Post" => {
    "actions" => {
      "creating a post" => {
        "admin" => {"permitted" => true, "note" => "email is registered", "note_number" => 1}
        "guest" => {"permitted" => false, "note" => nil, "note_number" => nil}
      }
      "editing a post" => {
        #...
      }
      "footnotes" => {
        1 => "email is registered"
      }
    }
  }
}
```

The Houserules::HtmlRenderer provides you this structure for you to use in your template. The gem provides an unstyled template `lib/templates/basic.html.erb` showing how to use this data to build a html table.




**** IMAGE GOES HERE*****



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/houserules. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Houserules project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/houserules/blob/master/CODE_OF_CONDUCT.md).
