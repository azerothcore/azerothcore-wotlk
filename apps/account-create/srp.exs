defmodule Srp do
  # Constants required in WoW's SRP6 implementation
  @n <<137, 75, 100, 94, 137, 225, 83, 91, 189, 173, 91, 139, 41, 6, 80, 83, 8, 1, 177, 142, 191,
       191, 94, 143, 171, 60, 130, 135, 42, 62, 155, 183>>
  @g <<7>>
  @field_length 32

  # Wrapper function
  def generate_stored_values(username, password, salt \\ "") do
    default_state()
    |> generate_salt(salt)
    |> calculate_x(username, password)
    |> calculate_v()
  end

  def default_state() do
    %{n: @n, g: @g}
  end

  # Generate salt if it's not defined
  def generate_salt(state, "") do
    salt = :crypto.strong_rand_bytes(32)
    Map.merge(state, %{salt: salt})
  end

  # Don't generate salt if it's already defined
  def generate_salt(state, salt) do
    padded_salt = pad_binary(salt)
    Map.merge(state, %{salt: padded_salt})
  end

  # Get h1
  def calculate_x(state, username, password) do
    hash = :crypto.hash(:sha, String.upcase(username) <> ":" <> String.upcase(password))
    x = reverse(:crypto.hash(:sha, state.salt <> hash))
    Map.merge(state, %{x: x, username: username})
  end

  # Get h2
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
