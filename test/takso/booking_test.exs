defmodule Takso.BookingTest do
  use ExUnit.Case
  alias Takso.Booking

  test "booking requires a pickup address" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: nil, dropoff_address: "Liivi 2"})
    assert Keyword.has_key?(changeset.errors, :pickup_address)
  end

  test "booking requires a dropoff address" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: "Liivi 2", dropoff_address: nil})
    assert Keyword.has_key?(changeset.errors, :dropoff_address)
  end

  test "booking with same pickup and dropoff addresses is invalid" do
    changeset = Booking.changeset(%Booking{}, %{
      pickup_address: "Liivi 2",
      dropoff_address: "Liivi 2"
    })
    assert Keyword.has_key?(changeset.errors, :dropoff_address)
    assert changeset.errors[:dropoff_address] == {"must be different from pickup address", []}
  end

  test "booking with different pickup and dropoff addresses is valid" do
    changeset = Booking.changeset(%Booking{}, %{
      pickup_address: "Liivi 2",
      dropoff_address: "Lõunakeskus"
    })
    assert changeset.valid?
  end
end
