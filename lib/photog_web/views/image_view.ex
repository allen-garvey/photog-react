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
    image_full_to_map(image)
  end

  def render("exif.json", %{image: image, exif: exif}) do
    %{data: %{
      image: %{
        id: image.id,
        master_path: image.master_path,
      },
      exif: %{
        camera: %{
          maker: exif["Make"],
          model: exif["Camera Model Name"],
          model_release_year: exif["Model Release Year"],
          lens_info: exif["Lens Info"],
          lens_model: exif["Lens Model"],
        },
        file: %{
          type: exif["File Type"],
          dimensions: exif["Image Size"],
          megapixels: exif["Megapixels"],
          creation_time: exif["Create Date"],
        },
        photo: %{
          aperature: exif["Aperture"],
          shutter: exif["Shutter Speed"],
          iso: exif["ISO"],
          orientation: exif["Camera Orientation"],
          camera_mode: exif["Exposure Program"],
          flash: exif["Flash"],
          focal_length: exif["Focal Length"],
          hdr: exif["HDR"],
        },
      },
    }}
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

  def image_full_to_map(image) do
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
      albums: Enum.map(image.albums, &PhotogWeb.AlbumView.album_excerpt_mini_to_map/1),
    }
  end
end
