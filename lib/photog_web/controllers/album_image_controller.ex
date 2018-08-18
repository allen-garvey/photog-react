defmodule PhotogWeb.AlbumImageController do
  use PhotogWeb, :controller

  alias Photog.Api
  alias Photog.Api.AlbumImage

  action_fallback PhotogWeb.FallbackController

  def index(conn, _params) do
    album_images = Api.list_album_images()
    render(conn, "index.json", album_images: album_images)
  end

  def create(conn, %{"album_image" => album_image_params}) do
    with {:ok, %AlbumImage{} = album_image} <- Api.create_album_image(album_image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", album_image_path(conn, :show, album_image))
      |> render("show.json", album_image: album_image)
    end
  end

  def show(conn, %{"id" => id}) do
    album_image = Api.get_album_image!(id)
    render(conn, "show.json", album_image: album_image)
  end

  def update(conn, %{"id" => id, "album_image" => album_image_params}) do
    album_image = Api.get_album_image!(id)

    with {:ok, %AlbumImage{} = album_image} <- Api.update_album_image(album_image, album_image_params) do
      render(conn, "show.json", album_image: album_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    album_image = Api.get_album_image!(id)
    with {:ok, %AlbumImage{}} <- Api.delete_album_image(album_image) do
      send_resp(conn, :no_content, "")
    end
  end
end
