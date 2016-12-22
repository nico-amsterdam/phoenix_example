defmodule PhoenixExample.PageControllerTest do
  use PhoenixExample.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "My examples"
  end
end
