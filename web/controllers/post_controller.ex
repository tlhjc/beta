defmodule Beta.PostController do
  use Beta.Web, :controller
  alias Beta.Post

  def configure_params(post_params, images) when images == [] do
    post_params
  end

  def configure_params(post_params, images) do
    image = List.first(images)
    case post_params[image] do
      nil    ->
        reduced_images = List.delete(images, image)
        configure_params(post_params, reduced_images)
      _image ->
        %{^image => image_params} = post_params

        file_uuid = UUID.uuid4(:hex)
        image_filename = image_params.filename
        filename = "#{file_uuid}-#{image_filename}"
        {:ok, image_binary} = File.read(image_params.path)
        bucket_name = System.get_env("BUCKET_NAME")

        _image =
          ExAws.S3.put_object(System.get_env("BUCKET_NAME"), filename, image_binary)
          |> ExAws.request!

        updated_params =
          post_params
          |> Map.update(image, image_params, fn _value -> "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{filename}" end)

        reduced_images = List.delete(images, image)
        configure_params(updated_params, reduced_images)
    end
  end

  def create(conn, %{"post" => post_params}) do
    images = ["image_1", "image_2", "image_3"]

    params = configure_params(post_params, images)

    changeset = Post.changeset(%Post{}, params)
    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created!")
        |> redirect(to: admin_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Error creating post!
        Check all fields have been entered and that the title is less than 150 characters.
        Also make sure that you have filled in at least two paragraphs and that the article link hasn't been entered previously")
        |> redirect(to: admin_path(conn, :index))
    end
  end
end
