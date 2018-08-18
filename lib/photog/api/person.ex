defmodule Photog.Api.Person do
  use Ecto.Schema
  import Ecto.Changeset


  schema "persons" do
    field :apple_photos_id, :integer
    field :name, :string
    field :cover_image_id, :id

    timestamps()

    belongs_to :image, Photog.Api.Image
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:apple_photos_id, :name, :cover_image_id])
    |> validate_required([:apple_photos_id, :name, :cover_image_id])
    |> unique_constraint(:apple_photos_id)
    |> unique_constraint(:name)
    |> assoc_constraint(:image)
    |> foreign_key_constraint(:cover_image_id)
  end
end
