defmodule Asanaficator.Tasks do
import Asanaficator
alias Asanaficator.Client

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
