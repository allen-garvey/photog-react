defmodule PhotogWeb.PersonView do
  use PhotogWeb, :view
  alias PhotogWeb.PersonView

  def render("index.json", %{persons: persons}) do
    %{data: render_many(persons, PersonView, "person_excerpt.json")}
  end

  def render("show.json", %{person: person}) do
    %{data: render_one(person, PersonView, "person.json")}
  end

  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      name: person.name,
      cover_image: PhotogWeb.ImageView.image_to_map(person.cover_image),
      images: Enum.map(person.images, &PhotogWeb.ImageView.image_full_to_map/1),
    }
  end

  def render("person_excerpt.json", %{person: person}) do
    %{
      id: person.id,
      name: person.name,
      cover_image: %{
        mini_thumbnail_path: person.cover_image.mini_thumbnail_path
      },
    }
  end
end
