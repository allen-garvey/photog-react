defmodule Photog.Api.Folder do
  use Ecto.Schema
  import Ecto.Changeset


  schema "folders" do
    field :apple_photos_uuid, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:apple_photos_uuid, :name])
    |> validate_required([:apple_photos_uuid, :name])
    |> unique_constraint(:name)
    |> unique_constraint(:apple_photos_uuid)
  end
end
