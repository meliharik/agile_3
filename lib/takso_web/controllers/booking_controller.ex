defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Takso.Taxi
  alias Takso.Repo

  def create(conn, %{"pickup_address" => _pickup, "dropoff_address" => _dropoff}) do
    # Query to find available taxis
    query = from t in Taxi, where: t.status == "available"
    available_taxis = Repo.all(query)

    # Check if there are available taxis
    if length(available_taxis) > 0 do
      # Booking accepted
      conn
      |> put_status(:ok)
      |> json(%{status: "accepted", message: "Your taxi will arrive in #{:rand.uniform(15)} minutes"})
    else
      # No taxis available
      conn
      |> put_status(:ok)
      |> json(%{status: "rejected", message: "At present, there is no taxi available!"})
    end
  end
end
