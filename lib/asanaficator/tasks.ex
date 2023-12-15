defmodule Asanaficator.Task do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  Struct for Task, like all Asana structs, is primarily sufficiant for creating a task through the API and making further querys.

  This structure is not exhaustive of the data that a task can contain but should be simple to expand in future.

  more info on Asana tasks at: https://developers.asana.com/reference/tasks
  """

  defstruct(
    gid: nil,
    name: "",
    resource_type: "task",
    resource_subtype: "default_task",
    approval_status: nil,
    completed: false,
    due_at: nil,
    due_on: nil,
    html_notes: "null",
    liked: false,
    notes: "null",
    start_at: nil,
    start_on: nil,
    assignee: nil,
    assignee_section: nil,
    custom_fields: [{}], 
    followers: [{}],
    parent: nil,
    projects: [""],
    tags: [""],
    workspace: "",
    memberships: [{}], 
    dependencies: [{}],
    dependents: [{}]
  )

  @type t :: %__MODULE__{ 
    gid: binary,
    name: binary,
    resource_type:  binary,
    resource_subtype:  binary,
    approval_status:  binary,
    completed: boolean,
    due_at:  binary,
    due_on:  binary,
    html_notes: binary, 
    liked: boolean,
    notes: binary,
    start_at: binary,
    start_on: binary,
    #assignee: Asanaficator.User,
    #assignee_section: Asanaficator.Section ,
    #custom_fields: list(Asanaficator.CustomField) # This needs to be a custom_field struct
    followers: list(Asanaficator.CustomField),
    parent: t,
    #projects: list(Asanaficator.Project), 
    tags: list(binary), 
    workspace: Asanaficator.Workspace, 
    # memberships: list(Asanaficator.Membership) ,# This needs to be a project/user struct
    dependencies: list(Asanaficator.Task), 
    dependents: list(Asanaficator.Task)
  }

  @spec new() :: t
  def new(), do: struct(Asanaficator.Task)
  @doc """
  Get a single pull request
  
  ## Example
    Asanaficator.Tasks.get_task(1337 :: task_id, client, {optfields: asignee,custom_fields})

  more info at: https://developers.asana.com/reference/gettask  
  """
  @spec get_task(binary | integer, Client.t, List.t) :: Asanaficator.Task.t
  def get_task(task_id, client \\ %Client{}, params \\ []) do
    response = get "tasks/#{task_id}", client, params
    #response_convert = Map.new(response["data"], fn {k,v} -> {String.to_atom(k), v} end)
    #Kernel.struct(Asanaficator.Task, response_convert)
    cast(Asanaficator.Task, response)
  end


  @doc """
  Get tasks based on given clauses
  Must specify exactly one of project, tag, section, user task list, or assignee + workspace
  
  ## Example
    Asanaficator.Tasks.get_tasks(client, {assignee: 1234, workspace:4321}) 

  More info at: https://developers.asana.com/reference/gettasks
  """
  @spec get_tasks(Client.t, List.t) :: Asanaficator.response
  def get_tasks(client \\ %Client{}, params \\ []) do
    get("tasks", client, params)
  end


  @doc """
  Get tasks from a given project.

  ## Example
    Asanaificator.Tasks.get_project_tasks(313313 :: project_id, client, {optfields: asignee}

  more info at: https://developers.asana.com/reference/gettasksforproject
  """
  @spec get_project_tasks(binary | integer, Client.t, List.t) :: Asanaficator.response
  def get_project_tasks(project_id, client \\ %Client{}, params \\ []) do
    get("projects/#{project_id}/tasks", client, params)
  end
end
