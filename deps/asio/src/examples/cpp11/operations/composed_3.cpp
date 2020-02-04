//
// composed_3.cpp
// ~~~~~~~~~~~~~~
//
// Copyright (c) 2003-2018 Christopher M. Kohlhoff (chris at kohlhoff dot com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <asio/bind_executor.hpp>
#include <asio/io_context.hpp>
#include <asio/ip/tcp.hpp>
#include <asio/use_future.hpp>
#include <asio/write.hpp>
#include <cstring>
#include <functional>
#include <iostream>
#include <string>
#include <type_traits>
#include <utility>

using asio::ip::tcp;

//------------------------------------------------------------------------------

// In this composed operation we repackage an existing operation, but with a
// different completion handler signature. We will also intercept an empty
// message as an invalid argument, and propagate the corresponding error to the
// user. The asynchronous operation requirements are met by delegating
// responsibility to the underlying operation.
template <typename CompletionToken>
auto async_write_message(tcp::socket& socket,
    const char* message, CompletionToken&& token)
  // The return type of the initiating function is deduced from the combination
  // of CompletionToken type and the completion handler's signature. When the
  // completion token is a simple callback, the return type is always void.
  // In this example, when the completion token is asio::yield_context
  // (used for stackful coroutines) the return type would be also be void, as
  // there is no non-error argument to the completion handler. When the
  // completion token is asio::use_future it would be std::future<void>.
  -> typename asio::async_result<
    typename std::decay<CompletionToken>::type,
    void(std::error_code)>::return_type
{
  // The asio::async_completion object takes the completion token and
  // from it creates:
  //
  // - completion.completion_handler:
  //     A completion handler (i.e. a callback) with the specified signature.
  //
  // - completion.result:
  //     An object from which we obtain the result of the initiating function.
  asio::async_completion<CompletionToken,
    void(std::error_code)> completion(token);

  // If the user passes an empty message, this operation results in an
  // invalid_argument error. This error is propagated to the user using the
  // asio::post operation. The async_write operation is used only for
  // valid input.
  //
  // The post operation has a completion handler signature of:
  //
  //   void()
  //
  // and the async_write operation has a completion handler signature of:
  //
  //   void(std::error_code error, std::size n)
  //
  // Both of these operations' completion handler signatures differ from our
  // operation's completion handler signature. We will adapt our completion
  // handler to these signatures by using std::bind, which drops the additional
  // arguments.
  //
  // However, it is essential to the correctness of our composed operation that
  // we preserve the executor of the user-supplied completion handler. The
  // std::bind function will not do this for us, so we must do this by first
  // obtaining the completion handler's associated executor (defaulting to the
  // I/O executor - in this case the executor of the socket - if the completion
  // handler does not have its own) ...
  auto executor = asio::get_associated_executor(
      completion.completion_handler, socket.get_executor());

  // ... and then binding it to our adapted completion handlers using the
  // asio::bind_executor function.
  std::size_t length = std::strlen(message);
  if (length == 0)
  {
    asio::post(
        asio::bind_executor(executor,
          std::bind(std::move(completion.completion_handler),
            asio::error::invalid_argument)));
  }
  else
  {
    asio::async_write(socket,
        asio::buffer(message, length),
        asio::bind_executor(executor,
          std::bind(std::move(completion.completion_handler),
            std::placeholders::_1)));
  }

  // Finally, we return the result of the initiating function.
  return completion.result.get();
}

//------------------------------------------------------------------------------

void test_callback()
{
  asio::io_context io_context;

  tcp::acceptor acceptor(io_context, {tcp::v4(), 55555});
  tcp::socket socket = acceptor.accept();

  // Test our asynchronous operation using a lambda as a callback.
  async_write_message(socket, "",
      [](const std::error_code& error)
      {
        if (!error)
        {
          std::cout << "Message sent\n";
        }
        else
        {
          std::cout << "Error: " << error.message() << "\n";
        }
      });

  io_context.run();
}

//------------------------------------------------------------------------------

void test_future()
{
  asio::io_context io_context;

  tcp::acceptor acceptor(io_context, {tcp::v4(), 55555});
  tcp::socket socket = acceptor.accept();

  // Test our asynchronous operation using the use_future completion token.
  // This token causes the operation's initiating function to return a future,
  // which may be used to synchronously wait for the result of the operation.
  std::future<void> f = async_write_message(
      socket, "", asio::use_future);

  io_context.run();

  try
  {
    // Get the result of the operation.
    f.get();
    std::cout << "Message sent\n";
  }
  catch (const std::exception& e)
  {
    std::cout << "Exception: " << e.what() << "\n";
  }
}

//------------------------------------------------------------------------------

int main()
{
  test_callback();
  test_future();
}
