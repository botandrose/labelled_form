require "labelled_form/version"
require "action_view"

module LabelledForm
  class Rails < ::Rails::Engine
    initializer "labelled_form.installation" do
      ActionView::Base.default_form_builder = Builder
    end
  end if defined?(Rails)

  class Builder < ActionView::Helpers::FormBuilder
    def with_label method, options
      wrap_in_dfn = options.delete(:wrap_in_dfn)
      label_class = options.delete(:label_class)
      label_with_colon = options.delete(:label_with_colon)
      label_text = options.delete(:label) || label_class.present? || label_with_colon

      label_text = method.to_s.humanize if label_text === true
      label_text&.sub!(/_id$/,"")
      label_text << ":" if label_with_colon && !label_text.ends_with?(":")

      field_html = yield

      if label_text
        if wrap_in_dfn
          @template.tag.dfn do
            @template.tag.dt(label(method, label_text, class: label_class)) +
              @template.tag.dd(field_html)
          end
        else
          label(method, label_text, class: label_class) + " ".html_safe + field_html
        end
      else
        field_html
      end
    end

    def text_area method, options = {}
      with_label(method, options) do
        super
      end
    end

    def date_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def phone_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def email_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def url_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def text_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def file_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      label_options = (options.keys & %i[wrap_in_dfn label_class label_with_colon label]).any? ? options : html_options
      with_label(method, label_options) do
        super
      end
    end

    def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
      label_options = (options.keys & %i[wrap_in_dfn label_class label_with_colon label]).any? ? options : html_options
      with_label(method, label_options) do
        super
      end
    end

    def number_field method, options = {}
      with_label(method, options) do
        super
      end
    end

    def radio_button(method, tag_value, options = {})
      options = options.dup
      label_text = options.delete(:label)
      label_class = options.delete(:label_class)
      super.tap do |out|
        if label_text
          label_text = tag_value if label_text === true
          out << " ".html_safe
          out << label(method, label_text, value: tag_value, class: label_class)
        end
      end
    end

    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      options = options.dup
      label_text = options.delete(:label)
      label_class = options.delete(:label_class)
      super.tap do |out|
        if label_text
          label_text = checked_value == "1" ? nil : checked_value if label_text === true
          out << " ".html_safe
          label_options = options[:multiple] ? { value: checked_value } : {}
          out << label(method, label_text, label_options.merge(class: label_class))
        end
      end
    end

    def multiple_check_box method, value, options={}
      options = options.dup
      label_text = options.delete(:label)
      label_class = options.delete(:label_class)
      out = "".html_safe

      if !multiple_check_box_fields.include?(method)
        multiple_check_box_fields << method
        out << hidden_field(method, value: "", multiple: true)
      end

      out << check_box(method, { multiple: true }.reverse_merge(options), value, nil)

      if label_text
        label_text = value == "1" ? nil : value if label_text === true
        out << " ".html_safe
        out << label(method, label_text, value: value, class: label_class)
      end

      out
    end

    private def multiple_check_box_fields
      @multiple_check_box_fields ||= Set.new
    end
  end
end
