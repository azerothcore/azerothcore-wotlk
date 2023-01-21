#!/usr/bin/env elixir

# Execute this Elixir script with the below command
#
# $  ACORE_USERNAME=foo ACORE_PASSWORD=barbaz123 elixir account.exs
#
# Set environment variables for basic configuration 
#
# ACORE_USERNAME - Username for account, default "admin"
# ACORE_PASSWORD - Password for account, default "admin"
# MYSQL_DATABASE - Database name, default "acore_auth"
# MYSQL_USERNAME - MySQL username, default "root"
# MYSQL_PASSWORD - MySQL password, default "password"
# MYSQL_PORT     - MySQL Port, default 3306
# MYSQL_HOST     - MySQL Host, default "localhost"

[
  {:myxql, "~> 0.6.0"}
]
|> Mix.install()

defmodule Account do
  @n <<137, 75, 100, 94, 137, 225, 83, 91, 189, 173, 91, 139, 41, 6, 80, 83, 8, 1, 177, 142, 191,
       191, 94, 143, 171, 60, 130, 135, 42, 62, 155, 183>>
  @g <<7>>
  @field_length 32

  def generate_stored_values(username, password, salt \\ "") do
    default_state()
    |> generate_salt(salt)
    |> calculate_x(username, password)
    |> calculate_v()
  end

  def default_state() do
    %{n: @n, g: @g}
  end

  def generate_salt(state, "") do
    salt = :crypto.strong_rand_bytes(32)
    Map.merge(state, %{salt: salt})
  end

  def generate_salt(state, salt) do
    padded_salt = pad_binary(salt)
    Map.merge(state, %{salt: padded_salt})
  end

  def calculate_x(state, username, password) do
    hash = :crypto.hash(:sha, String.upcase(username) <> ":" <> String.upcase(password))
    x = reverse(:crypto.hash(:sha, state.salt <> hash))
    Map.merge(state, %{x: x, username: username})
  end

  def calculate_v(state) do
    verifier =
      :crypto.mod_pow(state.g, state.x, state.n)
      |> reverse()
      |> pad_binary()

    Map.merge(state, %{verifier: verifier})
  end

  defp pad_binary(blob) do
    pad = @field_length - byte_size(blob)
    <<blob::binary, 0::pad*8>>
  end

  defp reverse(binary) do
    binary
    |> :binary.decode_unsigned(:big)
    |> :binary.encode_unsigned(:little)
  end
end

username_lower =
  System.get_env("ACORE_USERNAME", "admin")
  |> tap(&IO.puts("Account to create: #{&1}"))

username = String.upcase(username_lower)

password = System.get_env("ACORE_PASSWORD", "admin")

{:ok, pid} =
  MyXQL.start_link(
    protocol: :tcp,
    database: System.get_env("MYSQL_DATABASE", "acore_auth"),
    username: System.get_env("MYSQL_USERNAME", "root"),
    password: System.get_env("MYSQL_PASSWORD", "password"),
    port: System.get_env("MYSQL_PORT", "3306") |> String.to_integer(),
    hostname: System.get_env("MYSQL_HOST", "localhost")
  )

IO.puts("MySQL connection created")

%{salt: salt, verifier: verifier} = Account.generate_stored_values(username, password)

IO.puts("New salt and verifier generated")

result =
  MyXQL.query(
    pid,
    """
    INSERT INTO account
      (`username`, `salt`, `verifier`)
    VALUES
      (?, ?, ?)
    ON DUPLICATE KEY UPDATE salt=?, verifier=?
    """,
    [username, salt, verifier, salt, verifier]
  )

case result do
  {:error, %{message: message}} ->
    File.write("fail.log", message)

    IO.puts(
      "Account #{username_lower} failed to create. You can check the error message at fail.log."
    )

    exit({:shutdown, 1})

  {:ok, %{num_rows: 1}} ->
    IO.puts(
      "Account #{username_lower} has been created. You should now be able to login with that account"
    )

  {:ok, %{num_rows: 2}} ->
    IO.puts(
      "Account #{username_lower} has had its' password reset. You should now be able to login with that account"
    )
end
