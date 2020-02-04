set(target_prefix asio_cpp14_)

set(noinst_PROGRAMS
  echo/async_tcp_echo_server
  echo/async_udp_echo_server
  echo/blocking_tcp_echo_client
  echo/blocking_tcp_echo_server
  echo/blocking_udp_echo_client
  echo/blocking_udp_echo_server
  executors/actor
  executors/async_1
  executors/async_2
  executors/bank_account_1
  executors/bank_account_2
  executors/fork_join
  executors/pipeline
  executors/priority_scheduler
  iostreams/http_client)

set(echo_async_tcp_echo_server_SOURCES echo/async_tcp_echo_server.cpp)
set(echo_async_udp_echo_server_SOURCES echo/async_udp_echo_server.cpp)
set(echo_blocking_tcp_echo_client_SOURCES echo/blocking_tcp_echo_client.cpp)
set(echo_blocking_tcp_echo_server_SOURCES echo/blocking_tcp_echo_server.cpp)
set(echo_blocking_udp_echo_client_SOURCES echo/blocking_udp_echo_client.cpp)
set(echo_blocking_udp_echo_server_SOURCES echo/blocking_udp_echo_server.cpp)
set(executors_actor_SOURCES executors/actor.cpp)
set(executors_async_1_SOURCES executors/async_1.cpp)
set(executors_async_2_SOURCES executors/async_2.cpp)
set(executors_bank_account_1_SOURCES executors/bank_account_1.cpp)
set(executors_bank_account_2_SOURCES executors/bank_account_2.cpp)
set(executors_fork_join_SOURCES executors/fork_join.cpp)
set(executors_pipeline_SOURCES executors/pipeline.cpp)
set(executors_priority_scheduler_SOURCES executors/priority_scheduler.cpp)
set(iostreams_http_client_SOURCES iostreams/http_client.cpp)

foreach(program ${noinst_PROGRAMS})
  string(REPLACE "/" "_" target ${program})
  add_executable(${target_prefix}${target} ${${target}_SOURCES})
  set_target_properties(${target_prefix}${target} PROPERTIES
    CXX_STANDARD 14)
  target_link_libraries(${target_prefix}${target}
    asio::standalone)
  if(WIN32)
    target_link_libraries(${target_prefix}${target} wsock32 ws2_32)
  endif()
  install(TARGETS ${target_prefix}${target}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
endforeach()