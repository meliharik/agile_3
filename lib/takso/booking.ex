defmodule Takso.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :pickup_address, :string
    field :dropoff_address, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:pickup_address, :dropoff_address])
    |> validate_required([:pickup_address, :dropoff_address])
    |> validate_different_addresses()
  end

  defp validate_different_addresses(changeset) do
    pickup = get_change(changeset, :pickup_address)
    dropoff = get_change(changeset, :dropoff_address)

    if pickup && dropoff && pickup == dropoff do
      add_error(changeset, :dropoff_address, "must be different from pickup address")
    else
      changeset
    end
  end
end
