defmodule TaksoWeb.BookingControllerTest do
  use TaksoWeb.ConnCase
  alias Takso.Repo
  alias Takso.Taxi

  test "POST /api/bookings with valid data returns 200", %{conn: conn} do
    conn =
      post(conn, ~p"/api/bookings", %{
        "pickup_address" => "Tartu",
        "dropoff_address" => "Tallinn"
      })

    assert json_response(conn, 200)
  end

  test "POST /api/bookings rejects when no taxis available", %{conn: conn} do
    conn =
      post(conn, ~p"/api/bookings", %{
        "pickup_address" => "Liivi 2",
        "dropoff_address" => "Lõunakeskus"
      })

    response = json_response(conn, 200)
    assert response["status"] == "rejected"
    assert response["message"] == "At present, there is no taxi available!"
  end

  test "POST /api/bookings accepts when taxis are available", %{conn: conn} do
    # Insert an available taxi
    Repo.insert!(%Taxi{username: "testtaxi", location: "Tartu", status: "available"})

    conn =
      post(conn, ~p"/api/bookings", %{
        "pickup_address" => "Liivi 2",
        "dropoff_address" => "Lõunakeskus"
      })

    response = json_response(conn, 200)
    assert response["status"] == "accepted"
    assert response["message"] =~ "Your taxi will arrive in"
  end
end
