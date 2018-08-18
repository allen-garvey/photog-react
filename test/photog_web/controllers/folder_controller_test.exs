defmodule PhotogWeb.FolderControllerTest do
  use PhotogWeb.ConnCase

  alias Photog.Api
  alias Photog.Api.Folder

  @create_attrs %{apple_photos_uuid: "some apple_photos_uuid", name: "some name"}
  @update_attrs %{apple_photos_uuid: "some updated apple_photos_uuid", name: "some updated name"}
  @invalid_attrs %{apple_photos_uuid: nil, name: nil}

  def fixture(:folder) do
    {:ok, folder} = Api.create_folder(@create_attrs)
    folder
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all folders", %{conn: conn} do
      conn = get conn, folder_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create folder" do
    test "renders folder when data is valid", %{conn: conn} do
      conn = post conn, folder_path(conn, :create), folder: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, folder_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "apple_photos_uuid" => "some apple_photos_uuid",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, folder_path(conn, :create), folder: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update folder" do
    setup [:create_folder]

    test "renders folder when data is valid", %{conn: conn, folder: %Folder{id: id} = folder} do
      conn = put conn, folder_path(conn, :update, folder), folder: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, folder_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "apple_photos_uuid" => "some updated apple_photos_uuid",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, folder: folder} do
      conn = put conn, folder_path(conn, :update, folder), folder: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete folder" do
    setup [:create_folder]

    test "deletes chosen folder", %{conn: conn, folder: folder} do
      conn = delete conn, folder_path(conn, :delete, folder)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, folder_path(conn, :show, folder)
      end
    end
  end

  defp create_folder(_) do
    folder = fixture(:folder)
    {:ok, folder: folder}
  end
end
