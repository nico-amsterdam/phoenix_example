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
  end
end
