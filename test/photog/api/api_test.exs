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

  describe "images" do
    alias Photog.Api.Image

    @valid_attrs %{apple_photos_id: 42, creation_time: "2010-04-17 14:00:00.000000Z", is_favorite: true, master_path: "some master_path", mini_thumbnail_path: "some mini_thumbnail_path", thumbnail_path: "some thumbnail_path"}
    @update_attrs %{apple_photos_id: 43, creation_time: "2011-05-18 15:01:01.000000Z", is_favorite: false, master_path: "some updated master_path", mini_thumbnail_path: "some updated mini_thumbnail_path", thumbnail_path: "some updated thumbnail_path"}
    @invalid_attrs %{apple_photos_id: nil, creation_time: nil, is_favorite: nil, master_path: nil, mini_thumbnail_path: nil, thumbnail_path: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Api.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Api.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Api.create_image(@valid_attrs)
      assert image.apple_photos_id == 42
      assert image.creation_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert image.is_favorite == true
      assert image.master_path == "some master_path"
      assert image.mini_thumbnail_path == "some mini_thumbnail_path"
      assert image.thumbnail_path == "some thumbnail_path"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, image} = Api.update_image(image, @update_attrs)
      assert %Image{} = image
      assert image.apple_photos_id == 43
      assert image.creation_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert image.is_favorite == false
      assert image.master_path == "some updated master_path"
      assert image.mini_thumbnail_path == "some updated mini_thumbnail_path"
      assert image.thumbnail_path == "some updated thumbnail_path"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_image(image, @invalid_attrs)
      assert image == Api.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Api.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Api.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Api.change_image(image)
    end
  end
end
