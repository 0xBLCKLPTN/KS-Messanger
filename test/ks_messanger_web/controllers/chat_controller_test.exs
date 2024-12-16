defmodule KsMessangerWeb.ChatControllerTest do
  use KsMessangerWeb.ConnCase

  import KsMessanger.ChatsFixtures

  alias KsMessanger.Chats.Chat

  @create_attrs %{
    chat_name: "some chat_name",
    members: ["option1", "option2"]
  }
  @update_attrs %{
    chat_name: "some updated chat_name",
    members: ["option1"]
  }
  @invalid_attrs %{chat_name: nil, members: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all chats", %{conn: conn} do
      conn = get(conn, ~p"/api/chats")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create chat" do
    test "renders chat when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/chats", chat: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/chats/#{id}")

      assert %{
               "id" => ^id,
               "chat_name" => "some chat_name",
               "members" => ["option1", "option2"]
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/chats", chat: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update chat" do
    setup [:create_chat]

    test "renders chat when data is valid", %{conn: conn, chat: %Chat{id: id} = chat} do
      conn = put(conn, ~p"/api/chats/#{chat}", chat: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/chats/#{id}")

      assert %{
               "id" => ^id,
               "chat_name" => "some updated chat_name",
               "members" => ["option1"]
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, chat: chat} do
      conn = put(conn, ~p"/api/chats/#{chat}", chat: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete chat" do
    setup [:create_chat]

    test "deletes chosen chat", %{conn: conn, chat: chat} do
      conn = delete(conn, ~p"/api/chats/#{chat}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/chats/#{chat}")
      end
    end
  end

  defp create_chat(_) do
    chat = chat_fixture()
    %{chat: chat}
  end
end