defmodule Asanaficator.Tasks do
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
    resource_type: "",
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
    #custom_fields: {} # This needs to be a custom_field struct
    followers: [""],
    parent: nil,
    projects: [""],
    tags: [""],
    workspace: "",
    # memberships: {} # This needs to be a project/user struct
    dependencies: [{}],
    dependents: [{}]
  )
  @doc """
  Get a single pull request
  
  ## Example
    Asanaficator.Tasks.get_task(1337 :: task_id, client, {optfields: asignee,custom_fields})

  more info at: https://developers.asana.com/reference/gettask  
  """
  @spec get_task(binary | integer, Client.t, List.t) :: Asanaficator.response
  def get_task(task_id, client \\ %Client{}, params \\ []) do
    get "tasks/#{task_id}", client, params
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
    get "tasks", client, params
  end


  @doc """
  Get tasks from a given project.

  ## Example
    Asanaificator.Tasks.get_project_tasks(313313 :: project_id, client, {optfields: asignee}

  more info at: https://developers.asana.com/reference/gettasksforproject
  """
  @spec get_project_tasks(binary | integer, Client.t, List.t) :: Asanaficator.response
  def get_project_tasks(project_id, client \\ %Client{}, params \\ []) do
    get "projects/#{project_id}/tasks", client, params
  end
end
