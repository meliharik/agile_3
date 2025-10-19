defmodule TaksoWeb.BookingJSON do
  def create(%{booking: booking}) do
    %{data: data(booking)}
  end

  defp data(booking) do
    %{
      id: booking.id,
      pickup_address: booking.pickup_address,
      dropoff_address: booking.dropoff_address
    }
  end
end
