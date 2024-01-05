## Redbug

### Basic call trace

```
:redbug.start("queue:new")
```

### Stop

```
:redbug.stop()
```

### Print return value

```
:redbug.start("queue:new->return")
```

### Print return value and stack

```
:redbug.start("queue:new->return,stack")
```
