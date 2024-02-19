defmodule Asanaficator.Team do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  Struct for Team, like all Asana structs, is primarily sufficiant for creating a Team through the API and making further querys.

  This structure is not exhaustive of the data that a task can contain but should be simple to expand in future.

  more info on Asana tasks at: https://developers.asana.com/reference/teams
  """

  defstruct(
      gid: nil,
      resource_type: "team",
      name: "new_team",
      description: "This is my new team.",
      edit_team_name_or_description_access_level: nil,
      edit_team_visibility_or_team_access_level: nil,
      guest_invite_management_access_level: nil,
      html_descrption: nil,
      join_request_management_access_level: nil,
      member_invite_management_access_level: nil,
      organization: nil,
      team_member_removal_access_level: nil,
      visibility: nil
  )

  @type t :: %__MODULE__{
     gid: binary,
     resource_type: binary,
     name: binary,
     description: binary,
     edit_team_visibility_or_team_access_level: binary,
     edit_team_name_or_description_access_level: binary, 
     guest_invite_management_access_level: binary,
     html_descrption: binary, 
     join_request_management_access_level: binary,
     member_invite_management_access_level:  binary,
     organization: Asanaficator.Workspace,
     team_member_removal_access_level: binary,
     visibility: binary
  }

  @nest_fields %{organization: Asanaficator.Workspace}

  def get_nest_fields(), do: @nest_fields

  @spec new() :: t
  def new(), do: struct(Asanaficator.Team)

  @doc """
    Get a single team
    ## Example
      Asanaficator.Team.get_team(client, 1234 :: team_id, {optfields: name,gid})

      more info at: https://developers.asana.com/reference/getteam
  """
  @spec get_team(Client.t, binary | integer, List.t) :: Asanaficator.Team.t 
  def get_team(client \\ %Client{}, team_id, params \\ []) do 
    response = get(client, "teams/#{team_id}", params)
    cast(Asanaficator.Team, response["data"],@nest_fields) 
  end

  @doc """
    Get all teams in a workspace
    ## Example
      Asanaficator.Team.get_workspace_teams(client, 1234 :: workspace_id, {optfields: name, gid})

    more info at: https://developers.asana.com/reference/getteamsforworkspace
    """
  @spec get_workspace_teams(Client.t, binary | integer, List.t) :: Asanaficator.response
  def get_workspace_teams(client \\ %Client{}, workspace_id, params \\ []) do
    response = get(client, "workspaces/#{workspace_id}/teams", params)
    cast(Asanaficator.Team, response["data"], @nest_fields)
  end
    

end
