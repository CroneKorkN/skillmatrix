module ApplicationHelper
  def editable(
      object,
      method,
      display:      :name,
      display_with: nil,
      tag:          :span,
      trigger:      :auto,
      label:        :name
    )

    value       = object.send(method)

    model           = object.class.model_name.singular
    id              = object.send object.class.primary_key
    url             = url_for(object)
    identifier      = "#{method}_#{model}_#{id}"

    if object.class.columns_hash[method.to_s] # method is a column

      datatype        = object.class.columns_hash[method.to_s].type
      display_value   = display_with ? send(display_with, value) : value

      "<#{tag.to_s} class=\"editable\"\
      data-editable=\"#{identifier}\"\
      data-editable-model=\"#{model}\"\
      data-editable-id=\"#{id}\"\
      data-editable-method=\"#{method}\"\
      data-editable-datatype=\"#{datatype}\"\
      data-editable-value=\"#{value}\"\
      data-editable-url=\"#{url}\"\
      data-editable-display-with=\"#{display_with}\">
        #{display_value}
      </#{tag.to_s}>
      ".html_safe

    elsif object.class.reflections[method.to_s].class == ActiveRecord::Reflection::BelongsToReflection # method is a :1 assiciation

      "<div class=\"editable-helper\">
        <div class=\"editable\"\
        data-editable=\"#{identifier}\"\
        data-editable-model=\"#{model}\"\
        data-editable-id=\"#{id}\"\
        data-editable-method=\"#{method}\"\
        data-editable-datatype=\"single\"\
        data-editable-value=\"#{value.id}\"\
        data-editable-url=\"#{url}\"\
        data-editable-display-with=\"#{display_with}\">
          #{value.send(label)}
        </div>
        <ul class=suggestions></ul>
      </div>".html_safe

    elsif object.class.reflections[method.to_s].class == ActiveRecord::Reflection::HasManyReflection # method is a :n assiciation
      :multi
    else
      return "möp" # unless [:integer, :string].include? input_type
    end
  end
end
