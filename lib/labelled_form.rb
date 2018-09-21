require "labelled_form/version"
require "action_view"

module LabelledForm
  class Rails < ::Rails::Engine
    initializer "labelled_form.installation" do
      ActionView::Base.default_form_builder = Builder
    end
  end if defined?(Rails)

  class Builder < ActionView::Helpers::FormBuilder
    def text_area method, options = {}
      if label_text = options[:label]
        label_text = method.to_s.humanize if label_text === true
        label(method, label_text) + " ".html_safe + super
      else
        super
      end
    end

    def date_field method, options = {}
      if label_text = options[:label]
        label_text = method.to_s.humanize if label_text === true
        label(method, label_text) + " ".html_safe + super
      else
        super
      end
    end

    def email_field method, options = {}
      if label_text = options[:label]
        label_text = method.to_s.humanize if label_text === true
        label(method, label_text) + " ".html_safe + super
      else
        super
      end
    end

    def text_field method, options = {}
      if label_text = options[:label]
        label_text = method.to_s.humanize if label_text === true
        label(method, label_text) + " ".html_safe + super
      else
        super
      end
    end

    def radio_button(method, tag_value, options = {})
      label_text = options.delete(:label)
      super.tap do |out|
        if label_text
          label_text = tag_value if label_text === true
          label_field = :"#{method}_#{label_text.to_s.gsub(/\s/, "_").gsub(/[^-\w]/, "").downcase}"

          out << " ".html_safe
          out << label(label_field, label_text)
        end
      end
    end

    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      label_text = options.delete(:label)
      super.tap do |out|
        if label_text
          label_text = checked_value if label_text === true
          out << " ".html_safe
          label_options = options[:multiple] ? { value: checked_value } : {}
          out << label(method, label_text, label_options)
        end
      end
    end
  end
end
