defmodule PhoenixExample.Plug.MissingParameter do
  defexception [message: "Missing required parameter.",
                plug_status: 403]
end
