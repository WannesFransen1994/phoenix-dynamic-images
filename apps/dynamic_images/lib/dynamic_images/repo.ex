defmodule DynamicImages.Repo do
  use Ecto.Repo,
    otp_app: :dynamic_images,
    adapter: Ecto.Adapters.MySQL
end
