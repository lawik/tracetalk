## Entrace

### Setup

More upfront ceremony, familiar stuff though.

```
defmodule MyApp.Tracer do
    use Entrace.Tracer
end

{:ok, _} = Supervisor.start_link([MyApp.Tracer], strategy: :one_for_one)
```

### Default trace

```
MyApp.Tracer.trace({:queue, :new, 0}, &IO.inspect/1)
```

### First trace received, call

```
%Entrace.Trace{
  id: 5,
  mfa: {:queue, :new, []},
  pid: #PID<0.239.0>,
  called_at: ~U[2024-01-07 19:56:34.868879Z],
  returned_at: nil,
  return_value: nil,
  stacktrace: [
    {Tracetalk.Sampler, :handle_continue, 2,
     [file: ~c"lib/tracetalk/sampler.ex", line: 12]},
    {:gen_server, :try_handle_continue, 3,
     [file: ~c"gen_server.erl", line: 1067]},
    {:gen_server, :loop, 7, [file: ~c"gen_server.erl", line: 977]},
    {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 241]}
  ],
  caller: {Tracetalk.Sampler, :handle_continue, 2},
  caller_line: {Tracetalk.Sampler, :handle_continue, 2,
   {~c"lib/tracetalk/sampler.ex", 12}}
}
```

### Second trace received, return/exception

```
%Entrace.Trace{
  id: 5,
  mfa: {:queue, :new, []},
  pid: #PID<0.239.0>,
  called_at: ~U[2024-01-07 19:56:34.868879Z],
  returned_at: ~U[2024-01-07 19:56:34.868885Z],
  return_value: {:return, {[], []}},
  stacktrace: [
    {Tracetalk.Sampler, :handle_continue, 2,
     [file: ~c"lib/tracetalk/sampler.ex", line: 12]},
    {:gen_server, :try_handle_continue, 3,
     [file: ~c"gen_server.erl", line: 1067]},
    {:gen_server, :loop, 7, [file: ~c"gen_server.erl", line: 977]},
    {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 241]}
  ],
  caller: {Tracetalk.Sampler, :handle_continue, 2},
  caller_line: {Tracetalk.Sampler, :handle_continue, 2,
   {~c"lib/tracetalk/sampler.ex", 12}}
}
```

### Up-front setup preferred for better ergonomics

- Trace needs to be owned by a process and I don't want it to be iex
- The MyApp.Tracer follows the pattern of Ecto.Repo and Phoenix.PubSub for creating a named singleton to reduce unnecessary PID-juggling. Can also be done using primitives
- Safe limits by default
- Support multiple separate traces at once with separate limits
- Just as simple to trace the entire cluster with `trace_cluster` instead of `trace`
- Separate trace results for call and return/exception
- Structured response format
- Plenty of information by default
- Uses new caller_line and current_stacktrace information if run under OTP-26, see PR for [ex2ms](https://github.com/ericmj/ex2ms/pull/36)

### To explore

- Sequential tracing (laying a trap for your bug)
- Trace process activities: spawn, send, receive