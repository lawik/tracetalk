## Recon tracing

### Basic call trace

```
:recon_trace.calls({:queue, :new, :_}, 5)
```

### Print return value

```
import Ex2ms
:recon_trace.calls({:queue, :new, fun do return_trace() end}, 5)
```

### Print return value and stack

```
:redbug.start("queue:new->return,stack")
```
