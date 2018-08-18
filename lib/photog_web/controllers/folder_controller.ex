defmodule PhotogWeb.FolderController do
  use PhotogWeb, :controller

  alias Photog.Api
  alias Photog.Api.Folder

  action_fallback PhotogWeb.FallbackController

  def index(conn, _params) do
    folders = Api.list_folders()
    render(conn, "index.json", folders: folders)
  end

  def create(conn, %{"folder" => folder_params}) do
    with {:ok, %Folder{} = folder} <- Api.create_folder(folder_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", folder_path(conn, :show, folder))
      |> render("show.json", folder: folder)
    end
  end

  def show(conn, %{"id" => id}) do
    folder = Api.get_folder!(id)
    render(conn, "show.json", folder: folder)
  end

  def update(conn, %{"id" => id, "folder" => folder_params}) do
    folder = Api.get_folder!(id)

    with {:ok, %Folder{} = folder} <- Api.update_folder(folder, folder_params) do
      render(conn, "show.json", folder: folder)
    end
  end

  def delete(conn, %{"id" => id}) do
    folder = Api.get_folder!(id)
    with {:ok, %Folder{}} <- Api.delete_folder(folder) do
      send_resp(conn, :no_content, "")
    end
  end
end
