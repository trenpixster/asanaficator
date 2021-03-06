defmodule Asanaficator.Users do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  Get a single `user`

  ## Example

      Asanaficator.Users.find 123456, client

  More info at: https://asana.com/developers/api-reference/users#get-single
  """
  @spec find(binary, Client.t) :: Asanaficator.response
  def find(user, client \\ %Client{}) do
    get "users/#{user}", client
  end

  @doc """
  Get the authenticated user

  ## Example

      Asanaficator.Users.me(client)

  More info at: https://asana.com/developers/api-reference/users#get-single
  """
  @spec me(Client.t) :: Asanaficator.response
  def me(client) do
    get "users/me", client
  end
end
