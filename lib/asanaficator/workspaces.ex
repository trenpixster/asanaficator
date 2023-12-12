defmodule Asanaficator.Workspace do
import Asanaficator
alias Asanaficator.Client
  defstruct(
      gid: nil,
      resource_type: "",
      name: "",
      email_domains: [],
      is_organisation: false
  )

  @type t :: %__MODULE__{
      gid: binary,
      resource_type: binary,
      name: binary,
      email_domains: list(binary),
      is_organisation: boolean
  }
  
  @spec new() :: t
  def new(), do: struct(Asanaficator.Workspace)


  @doc """
  Get a single Workspace 

  ## Example
  Asanaficator.Workspaces.get_workspace(1337 :: workspace_id, client, {optfields: name, is_organization}

  more info at: https://developers.asana.com/reference/getworkspace
"""
  @spec get_workspace(binary | integer, Client.t, List.t) :: Asanaficator.response
  def get_workspace(workspace_id, client \\ %Client{}, params \\ []) do
    get "workspaces/#{workspace_id}", client, params
  end

  @doc """
  Get all Workspaces visible to client

  ## Example
  Asanaficator.Workspaces.get_workspaces(client, {optfields: name, is_organization}

  more info at: https://developers.asana.com/reference/getworkspaces 
  """
  @spec get_workspaces(Client.t, List.t) :: Asanaficator.response
  def get_workspaces(client \\ %Client{}, params \\ []) do
    get "workspaces", client, params
  end
end
