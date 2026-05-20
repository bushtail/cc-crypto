# Built-in PRNG
- `math.random()`
- `math.randomseed(seed)`

# Time-based entropy
- `os.time()`
- `os.day()`
- `os.clock()`
- `os.clock()` deltas
- `os.epoch("utc")` WITH:
- `os.epoch("local")`

# User input entropy
- `key`
- `char`
- `mouse_click`
- `mouse_drag`
- `mouse_scroll`
- Reaction time between events

# Network entropy
- `rednet.receive()`
- `modem_message`
- Packet arrival jitter

# World entropy
- `gps.locate()`

# Turtle entropy
- `turtle.getFuelLevel()`
- `turtle.inspect()`
- `turtle.turnLeft()` / `turtle.turnRight()`
- `turtle.forward()`
- `gps.locate()`

# Redstone entropy
- `redstone.getInput()`
- `redstone.getAnalogInput()`
- Signal timing

# Peripheral entropy
- inventory and storage
- sensors and blocks
- interaction timing

# Filesystem entropy
- `disk`
- `fs.open` and other file change events

# Event entropy
- `os.pullEvent()`
- `timer`

# Parallel entropy
- `parallel.waitForAny()`
