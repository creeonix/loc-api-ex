defmodule LocationsApi.RedisClient do

  def client do
    _get_pid || _connect
  end

  defp _get_pid do
    Process.whereis(:redis_client)
  end

  defp _connect do
    Exredis.start_using_connection_string(Application.get_env(:exredis, :url))
      |> Process.register :redis_client

    _get_pid
  end

end
