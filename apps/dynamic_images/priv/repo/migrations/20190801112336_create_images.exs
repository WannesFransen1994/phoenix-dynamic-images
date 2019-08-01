defmodule DynamicImages.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :filename, :string
      add :content_type, :string
      add :hash, :string, size: 64
      add :size, :bigint
    end
  end
end
