defmodule PhotogWeb.PersonImageController do
  use PhotogWeb, :controller

  alias Photog.Api
  alias Photog.Api.PersonImage

  action_fallback PhotogWeb.FallbackController

  def index(conn, _params) do
    person_images = Api.list_person_images()
    render(conn, "index.json", person_images: person_images)
  end

  def create(conn, %{"person_image" => person_image_params}) do
    with {:ok, %PersonImage{} = person_image} <- Api.create_person_image(person_image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", person_image_path(conn, :show, person_image))
      |> render("show.json", person_image: person_image)
    end
  end

  def show(conn, %{"id" => id}) do
    person_image = Api.get_person_image!(id)
    render(conn, "show.json", person_image: person_image)
  end

  def update(conn, %{"id" => id, "person_image" => person_image_params}) do
    person_image = Api.get_person_image!(id)

    with {:ok, %PersonImage{} = person_image} <- Api.update_person_image(person_image, person_image_params) do
      render(conn, "show.json", person_image: person_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    person_image = Api.get_person_image!(id)
    with {:ok, %PersonImage{}} <- Api.delete_person_image(person_image) do
      send_resp(conn, :no_content, "")
    end
  end
end
