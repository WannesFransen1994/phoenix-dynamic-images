defmodule DynamicImages.ImageContext do
  alias DynamicImages.{Image, Repo}

  def create_image(%{filename: _, path: tmp_path, content_type: _} = upload) do
    hash = File.stream!(tmp_path, [], 2048) |> Image.sha256()

    with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path),
         data_merged <- Map.from_struct(upload) |> Map.merge(%{size: size, hash: hash}),
         {:ok, upload_cs} <- %Image{} |> Image.changeset(data_merged) |> Repo.insert(),
         :ok <- tmp_path |> File.cp(Image.local_path(upload_cs)) do
      {:ok, upload_cs}
    else
      {:error, reason} -> Repo.rollback(reason)
    end
  end
end
