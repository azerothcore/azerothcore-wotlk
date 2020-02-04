set(target_prefix asio_cpp11_)

set(noinst_PROGRAMS
  allocation/server
  buffers/reference_counted
  chat/chat_client
  chat/chat_server
  echo/async_tcp_echo_server
  echo/async_udp_echo_server
  echo/blocking_tcp_echo_client
  echo/blocking_tcp_echo_server
  echo/blocking_udp_echo_client
  echo/blocking_udp_echo_server
  executors/actor
  executors/bank_account_1
  executors/bank_account_2
  executors/fork_join
  executors/pipeline
  executors/priority_scheduler
  futures/daytime_client
  http/server/http_server
  invocation/prioritised_handlers
  iostreams/http_client
  multicast/receiver
  multicast/sender
  nonblocking/third_party_lib)

set(allocation_server_SOURCES allocation/server.cpp)
set(buffers_reference_counted_SOURCES buffers/reference_counted.cpp)
set(chat_chat_client_SOURCES chat/chat_client.cpp)
set(chat_chat_server_SOURCES chat/chat_server.cpp)
set(echo_async_tcp_echo_server_SOURCES echo/async_tcp_echo_server.cpp)
set(echo_async_udp_echo_server_SOURCES echo/async_udp_echo_server.cpp)
set(echo_blocking_tcp_echo_client_SOURCES echo/blocking_tcp_echo_client.cpp)
set(echo_blocking_tcp_echo_server_SOURCES echo/blocking_tcp_echo_server.cpp)
set(echo_blocking_udp_echo_client_SOURCES echo/blocking_udp_echo_client.cpp)
set(echo_blocking_udp_echo_server_SOURCES echo/blocking_udp_echo_server.cpp)
set(executors_actor_SOURCES executors/actor.cpp)
set(executors_bank_account_1_SOURCES executors/bank_account_1.cpp)
set(executors_bank_account_2_SOURCES executors/bank_account_2.cpp)
set(executors_fork_join_SOURCES executors/fork_join.cpp)
set(executors_pipeline_SOURCES executors/pipeline.cpp)
set(executors_priority_scheduler_SOURCES executors/priority_scheduler.cpp)
set(futures_daytime_client_SOURCES futures/daytime_client.cpp)
set(http_server_http_server_SOURCES
  http/server/connection.cpp
  http/server/connection_manager.cpp
  http/server/main.cpp
  http/server/mime_types.cpp
  http/server/reply.cpp
  http/server/request_handler.cpp
  http/server/request_parser.cpp
  http/server/server.cpp)
set(invocation_prioritised_handlers_SOURCES invocation/prioritised_handlers.cpp)
set(iostreams_http_client_SOURCES iostreams/http_client.cpp)
set(multicast_receiver_SOURCES multicast/receiver.cpp)
set(multicast_sender_SOURCES multicast/sender.cpp)
set(nonblocking_third_party_lib_SOURCES nonblocking/third_party_lib.cpp)

foreach(program ${noinst_PROGRAMS})
  string(REPLACE "/" "_" target ${program})
  add_executable(${target_prefix}${target} ${${target}_SOURCES})
  set_target_properties(${target_prefix}${target} PROPERTIES
    CXX_STANDARD 11)
  target_link_libraries(${target_prefix}${target}
    asio::standalone)
  if(WIN32)
    target_link_libraries(${target_prefix}${target} wsock32 ws2_32)
  endif()
  install(TARGETS ${target_prefix}${target}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
endforeach()
