defmodule LocationsApi.Location do
  use Exredis.Api
  use Timex
  import LocationsApi.RedisClient, only: [ client: 0 ]
  alias LocationsApi.Location, as: Location

  defstruct uid: nil, lat: nil, lng: nil, address: "", created_at: ""

  def find(uid) do
    client |> hgetall "location:#{uid}:last"
  end

  def new(params = %{}) do
    %Location{
      uid: params["uid"],
      lat: String.to_float(params["lat"] || ""),
      lng: String.to_float(params["lng"] || ""),
      address: params["address"]
    }
  end

  def create(location = %{}) do
    location = %Location{ new(location) |  created_at: _timestamp }
    {result, errors} = validate(location)

    if result == :ok do
      update_last_record(location)
      client
        |> hmset("location:#{location.uid}:#{_date}:#{location.created_at}", to_redis_data(location))
      {:ok, location}
    else
      {:error, errors}
    end
  end

  def validate(location = %Location{}) do
    { errors, _ } = { %{}, location }
                      |> validate_presence(:uid)
                      |> validate_presence(:lat)
                      |> validate_presence(:lng)
                      |> validate_numeric(:lat)
                      |> validate_numeric(:lng)

    if Enum.empty?(errors) do
      { :ok, [] }
    else
      { :error, errors }
    end
  end

  defp update_last_record(location = %Location{}) do
    [last_timestamp] = client |> hmget("location:#{location.uid}:last", "created_at")
    if last_timestamp == :undefined || _timestamp(last_timestamp) < _timestamp do
      client
        |> hmset("location:#{location.uid}:last", to_redis_data(location))
    end
  end

  defp to_redis_data(location = %Location{}) do
    location
      |> Map.from_struct
      |> Map.keys
      |> Enum.flat_map fn(k) -> [ "#{k}", "#{Map.get(location, k)}" ] end
  end

  defp validate_presence({errors, location}, field) do
    value = Map.get(location, field)

    if is_nil(value) || "" == String.lstrip("#{value}") do
      errors = errors |> add_error(field, "Can't be blank")
    end

    {errors, location}
  end

  defp validate_numeric({errors, location}, field) do
    value = Map.get(location, field)

    if !is_number(value) do
      errors = errors |> add_error(field, "Must be numeric")
    end

    {errors, location}
  end

  defp add_error(errors, field, error) do
    Map.put(errors, field, (Map.get(errors, field) || []) ++ [error])
  end

  defp _date do
    {:ok, date} = DateFormat.format(Date.now, "%F", :strftime)
    date
  end

  defp _timestamp(date) do
    String.to_integer(date)
  end
  defp _timestamp do
    Date.convert(Date.now, :secs)
  end
end
