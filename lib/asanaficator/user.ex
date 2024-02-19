defmodule Asanaficator.User do
  import Asanaficator
  alias Asanaficator.Client

  defstruct(
    gid: nil,
    resource_type: "user",
    email: nil,
    name: nil,
    photo: nil,
    workspaces: []
  )

  @type t :: %__MODULE__ {
    gid: binary,
    resource_type: binary,
    email: binary,
    name: binary,
    photo: list(URI.t),
    workspaces: list(Asanaficator.Workspace)
  }

  @nest_fields %{workspaces: Asanaficator.Workspace}
  def get_nest_fields(), do: @nest_fields

  @doc """
  Get a single `user`

  ## Example

      Asanaficator.Users.get_user 123456, client, %{opt_fileds: gid, name}

  More info at: https://asana.com/developers/api-reference/users#get-single
  """
  @spec get_user(Client.t, integer|binary,  List.t) :: Asanaficator.User.t
  def get_user(client \\ %Client{}, user_id, params \\ []) do
    response = get(client, "users/#{user_id}", params)
    cast(Asanaficator.User, response, @nest_fields)
  end

  @doc """
  Get the authenticated user
  Note: The same can be achieved by doing get_user("me", client)

  ## Example

      Asanaficator.Users.me(client)

  More info at: https://asana.com/developers/api-reference/users#get-single
  """
  @spec me(Client.t, List.t) :: Asanaficator.User.t
  def me(client, params \\ []) do
    response = get client, "users/me", params
    cast(Asanaficator.User, response["data"], @nest_fields)
  end


  @doc """
  Get users based on given clauses
  Must specify one of project or workspace

  ## Example
    Asanaficator.User.get_users(client, {workspace: 123123, team: 123123})
  
  more info at: https://developers.asana.com/reference/getusers
  """
  @spec get_users(Client.t, List.t) :: [Asanaficator.User]
  def get_users(client \\ %Client{}, params \\ []) do
    response = get(client, "users", params)
    cast(Asanaficator.User, response["data"], @nest_fields)
  end
end
