defmodule PhotogWeb.ImageView do
  use PhotogWeb, :view
  alias PhotogWeb.ImageView

  def render("index.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    image_to_map(image)
  end

  def image_to_map(image) do
    %{
      id: image.id,
      creation_time: %{
        raw: image.creation_time,
        formatted: %{
          us_date: PhotogWeb.DatetimeHelpers.to_us_formatted_date(image.creation_time),
          time: PhotogWeb.DatetimeHelpers.to_formatted_time(image.creation_time),
        }
      },
      master_path: image.master_path,
      thumbnail_path: image.thumbnail_path,
      mini_thumbnail_path: image.mini_thumbnail_path,
      is_favorite: image.is_favorite,
    }
  end
end
