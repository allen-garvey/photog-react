defmodule Photog.ApiTest do
  use Photog.DataCase

  alias Photog.Api

  describe "folders" do
    alias Photog.Api.Folder

    @valid_attrs %{apple_photos_uuid: "some apple_photos_uuid", name: "some name"}
    @update_attrs %{apple_photos_uuid: "some updated apple_photos_uuid", name: "some updated name"}
    @invalid_attrs %{apple_photos_uuid: nil, name: nil}

    def folder_fixture(attrs \\ %{}) do
      {:ok, folder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_folder()

      folder
    end

    test "list_folders/0 returns all folders" do
      folder = folder_fixture()
      assert Api.list_folders() == [folder]
    end

    test "get_folder!/1 returns the folder with given id" do
      folder = folder_fixture()
      assert Api.get_folder!(folder.id) == folder
    end

    test "create_folder/1 with valid data creates a folder" do
      assert {:ok, %Folder{} = folder} = Api.create_folder(@valid_attrs)
      assert folder.apple_photos_uuid == "some apple_photos_uuid"
      assert folder.name == "some name"
    end

    test "create_folder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_folder(@invalid_attrs)
    end

    test "update_folder/2 with valid data updates the folder" do
      folder = folder_fixture()
      assert {:ok, folder} = Api.update_folder(folder, @update_attrs)
      assert %Folder{} = folder
      assert folder.apple_photos_uuid == "some updated apple_photos_uuid"
      assert folder.name == "some updated name"
    end

    test "update_folder/2 with invalid data returns error changeset" do
      folder = folder_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_folder(folder, @invalid_attrs)
      assert folder == Api.get_folder!(folder.id)
    end

    test "delete_folder/1 deletes the folder" do
      folder = folder_fixture()
      assert {:ok, %Folder{}} = Api.delete_folder(folder)
      assert_raise Ecto.NoResultsError, fn -> Api.get_folder!(folder.id) end
    end

    test "change_folder/1 returns a folder changeset" do
      folder = folder_fixture()
      assert %Ecto.Changeset{} = Api.change_folder(folder)
    end
  end
end
