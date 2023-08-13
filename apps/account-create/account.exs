#!/usr/bin/env elixir
# Execute this Elixir script with the below command
#
# $  ACORE_USERNAME=foo ACORE_PASSWORD=barbaz123 elixir account.exs
#
# Set environment variables for basic configuration 
#
# ACORE_USERNAME - Username for account, default "admin"
# ACORE_PASSWORD - Password for account, default "admin"
# ACORE_GM_LEVEL - GM level for account 
# MYSQL_DATABASE - Database name, default "acore_auth"
# MYSQL_USERNAME - MySQL username, default "root"
# MYSQL_PASSWORD - MySQL password, default "password"
# MYSQL_PORT     - MySQL Port, default 3306
# MYSQL_HOST     - MySQL Host, default "localhost"

# Install remote dependencies
[
  {:myxql, "~> 0.6.0"}
]
|> Mix.install()

# Start the logger
Application.start(:logger)
require Logger

# Constants
default_credential     = "admin"
default_gm_level       = "3"
account_access_comment = "Managed via account-create script"

# Import srp functions
Code.require_file("srp.exs", Path.absname(__DIR__))

# Assume operator provided a "human-readable" name. 
# The database stores usernames in all caps
username_lower =
  System.get_env("ACORE_USERNAME", default_credential)
  |> tap(&Logger.info("Account to create: #{&1}"))

username = String.upcase(username_lower)

password = System.get_env("ACORE_PASSWORD", default_credential)

gm_level = System.get_env("ACORE_GM_LEVEL", default_gm_level) |> String.to_integer()

if Range.new(0, 3) |> Enum.member?(gm_level) |> Kernel.not do
  Logger.info("Valid ACORE_GM_LEVEL values are 0, 1, 2, and 3. The given value was: #{gm_level}.")
end

{:ok, pid} =
  MyXQL.start_link(
    protocol: :tcp,
    database: System.get_env("MYSQL_DATABASE", "acore_auth"),
    username: System.get_env("MYSQL_USERNAME", "root"),
    password: System.get_env("MYSQL_PASSWORD", "password"),
    port: System.get_env("MYSQL_PORT", "3306") |> String.to_integer(),
    hostname: System.get_env("MYSQL_HOST", "localhost")
  )

Logger.info("MySQL connection created")

Logger.info("Checking database for user #{username_lower}")

# Check if user already exists in database
{:ok, result} = MyXQL.query(pid, "SELECT salt FROM account WHERE username=?", [username])

%{salt: salt, verifier: verifier} =
  case result do
    %{rows: [[salt | _] | _]} ->
      Logger.info("Salt for #{username_lower} found in database")
      # re-use the salt if the user exists in database
      Srp.generate_stored_values(username, password, salt)
    _ -> 
      Logger.info("Salt not found in database for #{username_lower}. Generating a new one")
      Srp.generate_stored_values(username, password)
  end

Logger.info("New salt and verifier generated")

# Insert values into DB, replacing the verifier if the user already exists
result =
  MyXQL.query(
    pid,
    """
    INSERT INTO account
      (`username`, `salt`, `verifier`)
    VALUES
      (?, ?, ?)
    ON DUPLICATE KEY UPDATE verifier=?
    """,
    [username, salt, verifier, verifier]
  )

case result do
  {:error, %{message: message}} ->
    File.write("fail.log", message)

    Logger.info(
      "Account #{username_lower} failed to create. You can check the error message at fail.log."
    )

    exit({:shutdown, 1})

  # if num_rows changed and last_insert_id == 0, it means the verifier matched. No change necessary
  {:ok, %{num_rows: 1, last_insert_id: 0}} ->
    Logger.info(
      "Account #{username_lower} doesn't need to have its' password changed. You should be able to log in with that account"
    )

  {:ok, %{num_rows: 1}} ->
    Logger.info(
      "Account #{username_lower} has been created. You should now be able to login with that account"
    )

  {:ok, %{num_rows: 2}} ->
    Logger.info(
      "Account #{username_lower} has had its' password reset. You should now be able to login with that account"
    )
end

# Set GM level to configured value
{:ok, _} = 
  MyXQL.query(
    pid, 
    """
    INSERT INTO account_access
      (`id`, `gmlevel`, `comment`)
    VALUES
      ((SELECT id FROM account WHERE username=?), ?, ?)
    ON DUPLICATE KEY UPDATE gmlevel=?, comment=?
    """, [username, gm_level, account_access_comment, gm_level, account_access_comment])

Logger.info("GM Level for #{username_lower} set to #{gm_level}")
