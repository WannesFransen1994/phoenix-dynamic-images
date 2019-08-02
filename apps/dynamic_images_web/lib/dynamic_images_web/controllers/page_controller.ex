defmodule DynamicImagesWeb.PageController do
  use DynamicImagesWeb, :controller

  alias DynamicImages.{Image, Repo, ImageContext}

  require Logger

  def index(conn, _params) do
    images = Repo.all(Image)
    render(conn, "index.html", images: images)
  end

  def create(conn, %{"upload" => %Plug.Upload{} = up}) do
    {:ok, _u} = up |> ImageContext.create_image()
    redirect(conn, to: Routes.page_path(conn, :index))
  end

  def display(conn, %{"id" => id}) do
    i = Repo.get(Image, id)

    case File.exists?(Image.local_path(i)) do
      true ->
        Logger.info("File with ID #{i.id} exists")

      false ->
        Logger.warn(
          "File with ID #{i.id}, path #{Image.local_path(i)} doesn't exist. Listing image folder content #{
            inspect(Path.wildcard("uploads/images/*"))
          }"
        )
    end

    conn |> put_resp_content_type(i.content_type) |> send_file(200, Image.local_path(i))
  end
end
