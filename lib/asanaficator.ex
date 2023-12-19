defmodule Asanaficator do
  use HTTPoison.Base

  defmodule Client do
    defstruct auth: nil, endpoint: "https://app.asana.com/api/1.0/"

    @type auth :: %{user: binary, password: binary} | %{access_token: binary}
    @type t :: %__MODULE__{auth: auth, endpoint: binary}

    @spec new() :: t
    def new(), do: %__MODULE__{}

    @spec new(auth) :: t
    def new(auth),  do: %__MODULE__{auth: auth}

    @spec new(auth, binary) :: t
    def new(auth, endpoint) do
      endpoint = if String.ends_with?(endpoint, "/") do
        endpoint
      else
        endpoint <> "/"
      end
      %__MODULE__{auth: auth, endpoint: endpoint}
    end
  end

  @user_agent [{"User-agent", "asanaficator"}]

  @type response :: {integer, any} | :jsx.json_term

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(response) do
    status_code = response.status_code
    headers = response.headers
    body = response.body
    response = unless body == "", do: body |> Poison.decode!,
    else: nil

    if (status_code == 200), do: response,
    else: {status_code, response}
  end

  @spec cast(module(), Asanaficator.response, Map) :: struct()
  def cast(mod, resp, nest_fields \\ %{}) do
    converted = Map.new(resp, fn {k,v} ->
      k = String.to_atom(k) 
      case Map.has_key?(nest_fields, k) do
        true -> 
        IO.puts("Nested key found: #{k}")
        {k, cast(nest_fields[k], v, nest_fields[k].get_nest_fields)} 

        _ -> {k, v}
      end
    end)
    Kernel.struct(mod, converted)
  end

  

  def delete(client, path, body \\ "") do
    _request(:delete, url(client, path), client.auth, body)
  end

  def post(client, path, body \\ "") do
    _request(:post, url(client, path), client.auth, body)
  end

  def patch(client, path, body \\ "") do
    _request(:patch, url(client, path), client.auth, body)
  end

  def put(client, path, body \\ "") do
    _request(:put, url(client, path), client.auth, body)
  end

  def get(client, path, params \\ []) do
    url = url(client, path)
    url = <<url :: binary, build_qs(params) :: binary>>
    _request(:get, url, client.auth)
  end

  def _request(method, url, auth, body \\ "") do
    json_request(method, url, body, authorization_header(auth, @user_agent))
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request!(method, url, Poison.encode!(body), headers, options) |> process_response
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request!(method, url, body, headers, options) |> process_response
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end


  @spec build_qs([{atom, binary}]) :: binary
  defp build_qs([]), do: ""
  defp build_qs(kvs), do: to_string('?' ++ URI.encode_query(kvs))

  @doc """
  There are two ways to authenticate through GitHub API v3:

    * Basic authentication
    * OAuth2 Token

  This function accepts both.

  ## More info
  https://asana.com/developers/documentation/getting-started/authentication
  """
  @spec authorization_header(Client.auth, list) :: list
  def authorization_header(%{user: user, password: password}, headers) do
    userpass = "#{user}:#{password}"
    headers ++ [{"Authorization", "Basic #{:base64.encode(userpass)}"}]
  end

  def authorization_header(%{access_token: token}, headers) do
    token = Base.encode64(token <> ":")
    headers ++ [{"Authorization", "Basic #{token}"}]
  end

  def authorization_header(_, headers), do: headers

  @doc """
  Same as `authorization_header/2` but defaults initial headers to include `@user_agent`.
  """
  def authorization_header(options), do: authorization_header(options, @user_agent)
end
