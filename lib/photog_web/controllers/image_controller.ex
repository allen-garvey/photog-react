defmodule PhotogWeb.ImageController do
  use PhotogWeb, :controller

  alias Photog.Api
  alias Photog.Api.Image

  action_fallback PhotogWeb.FallbackController

  def index(conn, _params) do
    images = Api.list_images()
    render(conn, "index.json", images: images)
  end

  def create(conn, %{"image" => image_params}) do
    with {:ok, %Image{} = image} <- Api.create_image(image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", image_path(conn, :show, image))
      |> render("show.json", image: image)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Api.get_image!(id)
    render(conn, "show.json", image: image)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Api.get_image!(id)

    with {:ok, %Image{} = image} <- Api.update_image(image, image_params) do
      render(conn, "show.json", image: image)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Api.get_image!(id)
    with {:ok, %Image{}} <- Api.delete_image(image) do
      send_resp(conn, :no_content, "")
    end
  end
end
