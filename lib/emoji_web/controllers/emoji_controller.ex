defmodule EmojiWeb.EmojiController do
  require Exmoji
  use EmojiWeb, :controller

  def show(conn, params) do
    # matchExmoji(conn, params["emoji_name"])
    matchEmoji(conn, params["emoji_name"])
  end

  def matchEmoji(conn, "vulcan") do
    json(conn, %{unicode: "🖖"})
  end
  def matchEmoji(conn, "sparkles") do
    json(conn, %{unicode: "✨"})
  end
  def matchEmoji(conn, "white check mark") do
    json(conn, %{unicode: "✅"})
  end
  def matchEmoji(conn, "nail care") do
    json(conn, %{unicode: "💅"})
  end
  def matchEmoji(conn, _) do
    conn
    |> put_status(404)
    |> json(%{error: "no emoji matches", found: "no"})
  end

  def matchExmoji(conn, emoji) do 
    Exmoji.from_short_name(emoji)
    |> Exmoji.EmojiChar.render
    |> Map.put(:unicode)
    json(conn, %{unicode:})
  end

end
