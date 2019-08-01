defmodule DynamicImages.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @upload_directory Application.get_env(:dynamic_images, :uploads_directory) <> "/images"
  alias DynamicImages.Image

  schema "images" do
    field :filename, :string
    field :content_type, :string
    field :hash, :string
    field :size, :integer
  end

  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [
      :filename,
      :content_type,
      :hash,
      :size
    ])
    |> validate_required([
      :filename,
      :content_type,
      :hash,
      :size
    ])
    |> validate_number(:size, greater_than: 0)
    |> validate_length(:hash, is: 64)
  end

  def sha256(chunks_enum) do
    chunks_enum
    |> Enum.reduce(
      :crypto.hash_init(:sha256),
      &:crypto.hash_update(&2, &1)
    )
    |> :crypto.hash_final()
    |> Base.encode16()
    |> String.downcase()
  end

  def local_path(%Image{} = upload) do
    [@upload_directory, "#{upload.id}-#{upload.filename}"] |> Path.join()
  end
end
