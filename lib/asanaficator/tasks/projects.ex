defmodule Asanaficator.Tasks.Projects do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  List Projects for task

  ## Example

      Asanaficator.Tasks.projects 1337, client

  More info at: https://asana.com/developers/api-reference/tasks#projects
  """
  @spec projects(binary | integer, Client.t) :: Asanaficator.response
  def projects(task_id, client \\ %Client{}) do
    get "tasks/#{task_id}/projects", client
  end

end