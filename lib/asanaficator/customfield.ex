defmodule Asanaficator.CustomField do
  import Asanaficator
  alias Asanaficator.Client

  @doc """
  Struct for custom field, like all Asana structs, is primarily sufficiant for creating a custom field through the API and making further querys.

  This structure is not exhaustive of the data that a custom field can contain but should be simple to expand in future.

  NOTE: types of custom field that have their own structures that do not exist outside of custom fields (e.g. enum fileds) are handled as maps - NOT their own Asanaficator structs like most other ensted fields in this library.

  more info on Asana tasks at: https://developers.asana.com/reference/tasks
  """

  defstruct(
  gid: nil,
  resource_type: "custom_field",
  date_value: nil, # Map
  display_value: "",
  enabled: false,
  enum_options: nil, # Map
  enum_value: nil, # Map
  is_formula_field: false,
  multi_enum_values: nil, # Map
  name: "",
  number_value: nil,
  resource_subtype: "text"
  )

  @type t :: %__MODULE__ {
  gid: binary,
  resource_type: binary,
  date_value: Map,
  display_value: binary,
  enabled: bool,
  enum_options: Map,
  enum_value: Map,
  is_formula_field: bool,
  multi_enum_values: Map,
  name: binary,
  number_value: integer,
  resource_subtype: binary 
  }

  @nest_fields %{}

  def get_nest_fields(), do: @nest_fields
  
  @spec new() :: t
  def new(), do: struct(Asanaficator.Customfield)

  @doc """ 
  Get a single custom field
  ## Example
    Asanaficator.CustomField.get_custom_field(client, 1337 :: custom_field_id, {optfields: enabled, format}

  more info at: https://developers.asana.com/reference/getcustomfield
  """
  @spec get_custom_field(Client.t, integer | binary, List.t) :: Asanaficator.CustomField.t
  def get_custom_field(client \\ %Client{}, custom_field_id, params \\ []) do
    response = get(client, "custom_fields/#{custom_field_id}", params)
    cast(Asanaficator.CustomField, response["data"], @nest_fields)
  end 

  @doc """ 
  Get a list of custom fields from a workspace
  ## Example 
    Asanaficator.CustomField.get_workspace_fields(client, 1337 :: workspace_id, {optfields: enampled, format}

  more info at: https://developers.asana.com/reference/getcustomfieldsforworkspace
  """
  @spec get_workspace_fields(Client.t, integer | binary, List.t) :: [Asanaficator.CustomField]
  def get_workspace_fileds(client \\ %Client{}, workspace_id, params \\ []) do
    response = get(client, "workspaces/#{workspace_id}/custom_fields", params)
    cast(Asanaficator.CustomField, response["data"], @nest_fields)
  end
end
