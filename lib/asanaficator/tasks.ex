defmodule Asanaficator.Tasks do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  Get a single pull request

  ## Example

      Asanaficator.Tasks.find 1337, client

  More info at: https://asana.com/developers/api-reference/tasks#get
  """
  @spec find(binary | integer, Client.t) :: Asanaficator.response
  def find(task_id, client \\ %Client{}) do
    get "tasks/#{task_id}", client
  end

end
