# LabelledForm

Adds `label:` option to Rails form helpers.

## Usage

Works like you'd expect, or at least, works like I'd expect! Examples:

```ruby
form_with :user do |form|

  # Prepends label to field and infers label text
  form.text_field :email, label: true
  # <label for="user_email">Email</label>
  # <input type="text" name="user[email]" id="user_email">

  # Supports specifying different label text
  form.text_field :name, label: "Full name"
  # <label for="user_name">Full name</label>
  # <input type="text" name="user[name]" id="user_name">

  # Appends label to field for radio buttons and checkboxes
  form.radio_button :gender, "Male", label: true
  # <input type="radio" name="user[gender]" value="Male" id="user_gender_male">
  # <label for="user_gender_male">Male</label>

end
```

## Todo
Figure out how to support options for the label tag, like `class:` and, uh, idk, other stuff. Maybe just pass options hash directly to `label:`? Maybe just start with additional `label_class:` option? Is there any other potential option for e.g. `form.label` we would care about? Probably should just cross this bridge when we get to it.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/botandrose/labelled_form.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
