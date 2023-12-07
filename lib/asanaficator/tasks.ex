defmodule Asanaficator.Tasks do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  Get a single pull request

  ## Example

      Asanaficator.Tasks.get_task 1337, client, {optfields: asignee,custom_fields} 

  More info at: https://asana.com/developers/api-reference/tasks#get
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
  """
  @spec get_tasks(Client.t, List.t) :: Asanaficator.response
  def get_tasks(client \\ %Client{}, params \\ []) do
    get "tasks", client, params
  end

end
