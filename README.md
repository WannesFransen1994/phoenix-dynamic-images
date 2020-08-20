# DynamicImages.Umbrella

Clone the repository

```bash
git clone https://github.com/WannesFransen1994/phoenix-dynamic-images.git
```

Configure your database in dev.exs (using MySQL)

Run the migrations

```bash
cd apps/dynamic_images
mix ecto.reset
cd ../..
```

And run the project

```bash
iex -S mix phx.server
```
