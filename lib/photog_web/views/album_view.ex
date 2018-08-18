defmodule PhotogWeb.AlbumView do
  use PhotogWeb, :view
  alias PhotogWeb.AlbumView

  def render("index.json", %{albums: albums}) do
    %{data: render_many(albums, AlbumView, "album.json")}
  end

  def render("show.json", %{album: album}) do
    %{data: render_one(album, AlbumView, "album.json")}
  end

  def render("album.json", %{album: album}) do
    %{id: album.id,
      name: album.name,
      folder_order: album.folder_order}
  end
end
