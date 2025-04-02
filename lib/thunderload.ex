defmodule Thunderload do
  use Application
  alias UUID

  def start(_type, _args) do
    IO.puts("Current process_limit: #{:erlang.system_info(:process_limit)}")
    Thunderload.main()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  defmodule LoadTest do
    def start do
      1..1_000_000
      |> Enum.each(fn task_num ->
        spawn(fn -> IO.puts("#{UUID.uuid4()} - #{task_num}") end)
      end)
    end
  end

  def main do
    IO.puts("Starting ThunderLoad V0.1.0 \n")
    IO.puts("Our first challenge - how to get this to do 1Mil UUID")
    LoadTest.start()
  end
end
