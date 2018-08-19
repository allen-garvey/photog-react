defmodule PhotogWeb.FolderView do
  use PhotogWeb, :view
  alias PhotogWeb.FolderView

  def render("index.json", %{folders: folders}) do
    %{data: render_many(folders, FolderView, "folder_excerpt.json")}
  end

  def render("show.json", %{folder: folder}) do
    %{data: render_one(folder, FolderView, "folder.json")}
  end

  def render("folder.json", %{folder: folder}) do
    %{
      id: folder.id,
      name: folder.name,
      albums: Enum.map(folder.albums, &folder_album/1)
    }
  end

  def render("folder_excerpt.json", %{folder: folder}) do
    %{id: folder.id,
      name: folder.name}
  end

  defp folder_album(album) do
    %{
      id: album.id,
      name: album.name,
      cover_image: %{
        mini_thumbnail_path: album.cover_image.mini_thumbnail_path
      }
    }
  end
end
