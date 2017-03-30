defmodule Beta.PostController do
  use Beta.Web, :controller
  alias Beta.Post

  def create(conn, %{"post" => post_params}) do
    IO.inspect post_params["image_1"]

    post_params =
      case post_params["image_1"] do
        nil    -> post_params
        _image ->
          %{"image_1" => image_1} = post_params

          file_uuid = UUID.uuid4(:hex)
          image_filename = image_1.filename
          filename = "#{file_uuid}-#{image_filename}"
          {:ok, image_binary} = File.read(image_1.path)
          bucket_name = System.get_env("BUCKET_NAME")

          _image =
            ExAws.S3.put_object(System.get_env("BUCKET_NAME"), filename, image_binary)
            |> ExAws.request!

          post_params =
            post_params
            |> Map.update("image_1", image_1, fn _value -> "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{filename}" end)
          post_params
      end
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created!")
        |> redirect(to: admin_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Error creating post!
        Check all fields have been entered and that the snippet is less than 150 characters.
        Also make sure that you have filled in at least two paragraphs and that the article link hasn't been entered previously")
        |> redirect(to: admin_path(conn, :index))
    end
  end
end
