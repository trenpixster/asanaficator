defmodule Asanaficator.ClientTest do
  use ExUnit.Case
  import Asanaficator

  doctest Asanaficator

 # setup_all do
 #   :meck.new(JSX, [:no_link])

 #   on_exit fn ->
 #     :meck.unload JSX
 #   end
 # end

 # test "authorization_header using user and password" do
 #   assert authorization_header(%{user: "user", password: "password"}, []) == [{"Authorization", "Basic dXNlcjpwYXNzd29yZA=="}]
 # end

 # test "authorization_header using access token" do
 #   assert authorization_header(%{access_token: "9820103"}, []) == [{"Authorization", "Basic OTgyMDEwMzo="}]
 # end


 # test "process response on a 200 response" do
 #   :meck.expect(JSX, :decode!, 1, :decoded_json)
 #   assert process_response(%HTTPoison.Response{ status_code: 200,
 #                                                headers: %{},
 #                                                body: "json" }) == :decoded_json
 #   assert :meck.validate(JSX)
 # end

 # test "process response on a non-200 response" do
 #   :meck.expect(JSX, :decode!, 1, :decoded_json)
 #   assert process_response(%HTTPoison.Response{ status_code: 404,
 #                                                headers: %{},
 #                                                body: "json" }) == {404, :decoded_json}
 #   assert :meck.validate(JSX)
 # end

 # test "process response on a non-200 response and empty body" do
 #   assert process_response(%HTTPoison.Response{ status_code: 404,
 #                                                headers: %{},
 #                                                body: "" }) == {404, nil}
 # end
end
