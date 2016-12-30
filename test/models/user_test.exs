defmodule PhoenixExample.UserTest do
  use PhoenixExample.ModelCase

  alias PhoenixExample.User

  @valid_attrs %{address: "some content", name: "some content", notifications_enabled: true, number_of_children: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
