defmodule EmojiWeb.EmojiController do
  require Exmoji
  use EmojiWeb, :controller

  @name_param "name"

  def match_single_emoji(conn, params) do
   
    case find_emoji(params["emoji_name"]) do 
      "" -> 
        conn
        |> put_status(404)
        |> json(%{error: "no emoji matches", found: "no"})
      _ ->
        conn
        |> json(%{unicode: List.first(find_emoji(params["emoji_name"]))})
    end
  end

  def match_any_emojis(conn, %{@name_param => param}) do
    case find_emoji(param) do 
      [""] -> 
        conn
        |> json(allEmoji)
      [] ->
        conn
        |> put_status(404)
        |> json(%{error: "no emoji matches", found: "no"})
      _ ->
        json(conn, find_emoji(param))
    end
  end

  def find_emoji("vulcan") do "🖖" end
  def find_emoji("sparkles") do "✨" end
  def find_emoji("white check mark") do "✅" end
  def find_emoji("nail care") do "💅" end
  def find_emoji(emoji) do
    Exmoji.find_by_short_name(emoji)
    |> Enum.map(fn (e) -> Exmoji.EmojiChar.render(e) end)
  end

  def allEmoji() do 
    Exmoji.all()
    |> Enum.map(fn (e) -> Exmoji.EmojiChar.render(e) end)
  end

end
