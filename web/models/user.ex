defmodule PhoenixExample.DeviceConfig do
  use PhoenixExample.Web, :model

  schema "user" do
    field :name, :string
    field :email, :string
    field :country, :string
    timestamps()
  end
end
