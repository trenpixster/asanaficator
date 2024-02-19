defmodule Asanaficator.Project do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
    Struct for Project, Like all Asana structs, is primariliy sufficiant for creating a project through the API and making further querys.

    This structure is not exhaustive of the data that a project can contain but should be simple to expand in future

    more info on Asana projects at: https://developers.asana.com/reference/projects
  """

  defstruct(
    gid: nil,
    name: "",
    resource_type: "project",
    archived: false,
    color: nil,
    created_at: nil,
    current_status: nil, # Asanaficator.StatusUpdate
    custom_field_settings: nil, # [Asanaficator.CustomFieldSettings]
    custom_fields: nil, # [Asanaficator.CustomField]
    default_view: nil,
    due_on: nil,
    html_notes: nil, 
    members: nil, # [Asanaficator.User]
    modified_at: nil,
    notes: nil,
    public: false,
    start_on: nil,
    workspace: nil, #Asanaficator.Workspace
    completed: nil,
    completed_by: nil, # Asanaficator.User
    created_from_template: nil, # Asanaficator.Template
    followers: nil, # [Asanaficator.User]
    icon: nil,
    owner: nil, # Asanaficator.User
    project_brief: nil, # Asanaficator.Brief
    team: nil # Asanaficator.Team
    )

    @type t :: %__MODULE__ {
    gid: binary,
    name: binary,
    resource_type: binary,
    archived: bool,
    color: binary,
    created_at: binary,
    # current_status: Asanaficator.StatusUpdate,
    # custom_field_settings: [Asanaficator.CustomFieldSettings],
    # custom_fields: [Asanaficator.CustomField],
    default_view: binary,
    due_on: binary,
    html_notes: binary, 
    # members: [Asanaficator.Membership],
    modified_at: binary,
    notes: binary,
    public: bool,
    start_on: binary,
    workspace: Asanaficator.Workspace,
    completed: binary,
    completed_by: Asanaficator.User,
    # created_from_template: Asanaficator.ProjectTemplate
    followers: [Asanaficator.User],
    icon: binary,
    owner: Asanaficator.User,
    # project_brief: Asanaficator.ProjectBrief,
    team: Asanaficator.Team
  }

  @nest_fields %{
    # current_status: Asanaficator.StatusUpdate,
    # custom_field_settings: [Asanaficator.CustomFieldSettings],
    # custom_fields: [Asanaficator.CustomField],
    # members: [Asanaficator.Membership],
    workspace: Asanaficator.Workspace,
    completed_by: Asanaficator.User,
    # created_from_template: Asanaficator.ProjectTemplate
    followers: [Asanaficator.User],
    owner: Asanaficator.User,
    # project_brief: Asanaficator.ProjectBrief,
    team: Asanaficator.Team
    }

  def get_nest_fields(), do: @nest_fields

  @spec new() :: t
  def new(), do: struct(Asanaficator.Project)

  @doc """
  get a single project 
  ## Example
    Asanaficator.Project.get_project(client, 1337 :: project_id, {optfields: workspace, custom_fields})

  more info at: https://developers.asana.com/reference/getproject
  """
  @spec get_project(Client.t, integer | binary, List.t) :: Asanaficator.Project.t
  def get_project(client \\ %Client{}, project_id, params \\ []) do
    response = get(client, "projects/#{project_id}", params)
    cast(Asanaficator.Project, response["data"], @nest_fields)
  end

  @doc """
  get multiple projects depending on given attributes 
  ## Example
    Asanaficator.Project.get_projects(client, {team: 123123})
  """
  @spec get_projects(Client.t, List.t) :: [Asanaficator.Project]
  def get_projects(client \\ %Client{}, params \\ []) do
    response = get(client, "projects", params)
    cast(Asanaficator.Project, response["data"], @nest_fields)
  end
  
  @doc """
  get count of tasks in a project 
  ## Example 
    Asanaficator.Project.get_task_count(client, 1337 :: project_id)

  NOTE: this end point DOES allow opt fields which are left out here, since this 
  should be single purpose and additional fields are very costly on this perticular 
  endpoint.

  more info: https://developers.asana.com/reference/gettaskcountsforproject
  """
  @spec get_task_count(Client.t, binary | integer) :: integer 
  def get_task_count(client \\ %Client{}, project_id) do
    response = get(client, "projects/#{project_id}/task_counts")
    response["data"]["num_tasks"] # NOTE that response data has more detail on the types of task that could be implemented here
  end
end
