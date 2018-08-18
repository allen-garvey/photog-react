defmodule Photog.Api.Image do
  use Ecto.Schema
  import Ecto.Changeset


  schema "images" do
    field :apple_photos_id, :integer
    field :creation_time, :utc_datetime
    field :is_favorite, :boolean, default: false
    field :master_path, :string
    field :mini_thumbnail_path, :string
    field :thumbnail_path, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:apple_photos_id, :creation_time, :master_path, :thumbnail_path, :mini_thumbnail_path, :is_favorite])
    |> validate_required([:apple_photos_id, :creation_time, :master_path, :thumbnail_path, :mini_thumbnail_path, :is_favorite])
    |> unique_constraint(:master_path)
    |> unique_constraint(:apple_photos_id)
  end
end