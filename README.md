# LabelledForm

Adds `label:` option to Rails form helpers.

## Usage

Works like you'd expect, or at least, works like I'd expect! Examples:

```ruby
= form_with :user do |form|

  # Prepends label to field and infers label text
  = form.text_field :email, label: true
  # <label for="user_email">Email</label>
  # <input type="text" name="user[email]" id="user_email">

  # Supports specifying different label text
  = form.text_field :name, label: "Full name"
  # <label for="user_name">Full name</label>
  # <input type="text" name="user[name]" id="user_name">

  # Appends label to field for radio buttons and checkboxes
  = form.radio_button :gender, "Male", label: true
  # <input type="radio" name="user[gender]" value="Male" id="user_gender_male">
  # <label for="user_gender_male">Male</label>

  # Specify label class
  = form.text_field :email, label_class: "hidden"
  # <label for="user_email" class="hidden">Email</label>
  # <input type="text" name="user[email]" id="user_email">

  # Append colon to label
  = form.text_field :email, label_with_colon: true
  # <label for="user_email">Email:</label>
  # <input type="text" name="user[email]" id="user_email">

  # Wrap whole thing in a <dfn>
  = form.text_field :email, wrap_in_dfn: true
  # <dfn>
  #   <dt><label for="user_email">Email</label></dt>
  #   <dd><input type="text" name="user[email]" id="user_email"></dd>
  # </dfn>

end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/botandrose/labelled_form.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

