defmodule PhoenixExample.InputHelpers do
  use Phoenix.HTML

  @moduledoc """
  Input controls with boilerplate
  """


  @doc """
  Input control
  """
  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "form-group #{state_class(form, field)}"]
    label_opts = [class: "control-label"]
    control_class = if type == :checkbox, do: "checkbox", else: "form-control"
    input_opts = [class: control_class]

    # add client-side validation
    validations = Phoenix.HTML.Form.input_validations(form, field)
    input_opts = Keyword.merge(validations, input_opts)

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      input = input(type, form, field, input_opts)
      error = PhoenixExample.ErrorHelpers.error_tag(form, field) || "" 
      [label, input, error]
    end
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  # Implement clauses below for custom inputs.
  defp input(:search_country, form, field, input_opts) do
    PhoenixFormAwesomplete.awesomplete(
      form,
      field,
      input_opts,
      %{
        url: "https://restcountries.eu/rest/v1/all",
        loadall: true,
        minChars: 1,
        maxItems: 8,
        value: "name"
      }
     )
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end

end
