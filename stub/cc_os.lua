---@meta

---@class os
os = os or {}

---@param filter? string
---@return string
---@return any ...
function os.pullEvent(filter) end

---@param filter? string
---@return string
---@return any ...
function os.pullEventRaw(filter) end

---@param path string
---@param ... any
---@return boolean success
function os.run(path, ...) end

---@param name string
---@param ... any
function os.queueEvent(name, ...) end

---@param time number
---@return number timer_id
function os.startTimer(time) end

---@param timer_id number
function os.cancelTimer(timer_id) end

---@param time number
---@return number alarm_id
function os.setAlarm(time) end

---@param alarm_id number
function os.cancelAlarm(alarm_id) end

---@return string|nil
function os.getComputerLabel() end

---@param label string
function os.setComputerLabel(label) end

---@return number
function os.getComputerID() end

function os.shutdown() end

function os.reboot() end

---@return number
function os.time() end

---@return number
function os.day() end

---@return number
function os.timeUnix() end

---@param mode? '"utc"'|'"local"'|'"ingame"'
---@return number
function os.epoch(mode) end

---@param seconds number
function os.sleep(seconds) end
