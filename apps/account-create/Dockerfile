FROM elixir:1.14-slim

RUN mix local.hex --force && \
    mix local.rebar --force

COPY account.exs /account.exs
COPY srp.exs /srp.exs
RUN chmod +x /account.exs

CMD /account.exs
