defmodule PhoenixExample.User do
  use PhoenixExample.Web, :model

  schema "users" do
    field :name, :string
    field :address, :string
    field :number_of_children, :integer
    field :notifications_enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :number_of_children, :notifications_enabled])
    |> validate_required([:name, :address, :number_of_children, :notifications_enabled])
    |> validate_length(:address, min: 3)
    |> validate_number(:number_of_children, greater_than_or_equal_to: 0)
  end
end
