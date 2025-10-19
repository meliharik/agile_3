defmodule TaksoWeb.BookingControllerTest do
  use TaksoWeb.ConnCase

  test "POST /api/bookings with valid data returns 200", %{conn: conn} do
    conn =
      post(conn, ~p"/api/bookings", %{
        "pickup_address" => "Tartu",
        "dropoff_address" => "Tallinn"
      })

    assert json_response(conn, 200)
  end
end
