defmodule EmojiWeb.EmojiControllerTest do
  use EmojiWeb.ConnCase

  describe "#match_single_emoji" do
    test "will return a known emoji", %{conn: conn} do
      conn = get(conn, "/emoji/vulcan")
      response = json_response(conn, 200)

      assert response["unicode"] == "🖖"
    end

    test "will retutn another emoji", %{conn: conn} do
      conn = get(conn, "/emoji/sunglasses")
      response = json_response(conn, 200)

      assert response["unicode"] == "😎"
    end

    test "will return a 404 when no emoji is found", %{conn: conn} do
      conn
      |> get("/emoji/blah blah")
      |> json_response(404)
    end
  end

  describe "match_any_emojis" do
    test "given a name param will return a matching list of emojis", %{conn: conn} do
      conn = get(conn, "/emojis?name=moon")
      response = json_response(conn, 200)

      assert length(response) == 13
    end

    test "given an unmatching name", %{conn: conn} do
      conn = get(conn, "/emojis?name=yoyoyoyoyoy")
      response = json_response(conn, 200)
      assert length(response) == 0
    end

    test "given no name will return all the emojis", %{conn: conn} do
      conn = get(conn, "/emojis")
      response = json_response(conn, 200)
      assert length(response) == 845
    end
  end
end
