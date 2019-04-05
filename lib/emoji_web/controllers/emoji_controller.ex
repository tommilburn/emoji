defmodule EmojiWeb.EmojiController do
  require Exmoji
  use EmojiWeb, :controller

  def match_single_emoji(conn, params) do
    case find_emoji(params["emoji_name"]) do
      emoji when is_binary(emoji) ->
        conn
        |> json(%{unicode: emoji})

      %Exmoji.EmojiChar{} = emoji ->
        conn
        |> json(%{unicode: Exmoji.EmojiChar.render(emoji)})

      nil ->
        conn
        |> put_status(404)
        |> json(%{error: "no emoji matches", found: "no"})
    end
  end

  def match_any_emojis(conn, %{"name" => param}) do
    emojis = Exmoji.find_by_short_name(param) |> render_emoji()
    json(conn, emojis)
  end
  def match_any_emojis(conn, _) do
    emojis = Exmoji.all() |> render_emoji()
    json(conn, emojis)
  end

  @spec find_emoji(binary) :: binary | Exmoji.EmojiChar.t() | nil
  def find_emoji("vulcan") do "🖖" end
  def find_emoji("sparkles") do "✨" end
  def find_emoji("white check mark") do "✅" end
  def find_emoji("nail care") do "💅" end
  def find_emoji(emoji) do
    Exmoji.from_short_name(emoji)
  end

  def render_emoji(emoji) do
    emoji
    |> Enum.map(&Exmoji.EmojiChar.render/1)
    |> Enum.map(&%{unicode: &1})
  end
end
