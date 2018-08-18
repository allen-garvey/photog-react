defmodule Photog.Api.AlbumImage do
  use Ecto.Schema
  import Ecto.Changeset


  schema "album_images" do
    field :order, :integer
    field :album_id, :id
    field :image_id, :id

    timestamps()
  end

  @doc false
  def changeset(album_image, attrs) do
    album_image
    |> cast(attrs, [:order, :album_id, :image_id])
    |> validate_required([:order, :album_id, :image_id])
    |> assoc_constraint(:image)
    |> foreign_key_constraint(:image_id)
    |> assoc_constraint(:album)
    |> foreign_key_constraint(:album_id)
    |> unique_constraint(:album_images_unique_composite, name: :album_images_unique_composite)
  end
end
