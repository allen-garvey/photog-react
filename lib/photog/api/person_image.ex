defmodule Photog.Api.PersonImage do
  use Ecto.Schema
  import Ecto.Changeset


  schema "person_images" do
    field :person_id, :id
    field :image_id, :id

    timestamps()
  end

  @doc false
  def changeset(person_image, attrs) do
    person_image
    |> cast(attrs, [:person_id, :image_id])
    |> validate_required([:person_id, :image_id])
    |> assoc_constraint(:image)
    |> foreign_key_constraint(:image_id)
    |> assoc_constraint(:person)
    |> foreign_key_constraint(:person_id)
    |> unique_constraint(:person_images_unique_composite, name: :person_images_unique_composite)
  end
end
