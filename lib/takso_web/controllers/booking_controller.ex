defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller

  def create(conn, %{"pickup_address" => _pickup, "dropoff_address" => _dropoff}) do
    json(conn, %{status: "ok"})
  end
end
