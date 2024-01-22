defmodule Asanaficator.WorkspaceTest do
  alias Asanaficator.Workspace
  alias Asanaficator.User
  use ExUnit.Case
  import Asanaficator
  import System

  doctest Asanaficator
  
  setup_all do
    api_key = System.get_env("ASANAFICATOR_TEST_KEY")
    client = Asanaficator.Client.new(%{access_token: api_key})
    me = User.me(client)
    %{client: client, me: me}
  end

  test "check type correct for workspaces", %{client: client, me: me} do
    [wp | _] = me.workspaces
    assert Kernel.is_struct(wp, Workspace)
  end
end
