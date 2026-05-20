---@meta

---@class turtle
turtle = turtle or {}

---@return boolean success
function turtle.forward() end

---@return boolean success
function turtle.back() end

---@return boolean success
function turtle.up() end

---@return boolean success
function turtle.down() end

---@return boolean success
function turtle.turnLeft() end

---@return boolean success
function turtle.turnRight() end

---@return boolean success
function turtle.dig() end

---@return boolean success
function turtle.digUp() end

---@return boolean success
function turtle.digDown() end

---@param text? string
---@return boolean success
function turtle.place(text) end

---@param text? string
---@return boolean success
function turtle.placeUp(text) end

---@param text? string
---@return boolean success
function turtle.placeDown(text) end

---@return boolean success
function turtle.attack() end

---@return boolean success
function turtle.attackUp() end

---@return boolean success
function turtle.attackDown() end

---@return boolean
function turtle.detect() end

---@return boolean
function turtle.detectUp() end

---@return boolean
function turtle.detectDown() end

---@return boolean success
---@return table|nil data
function turtle.inspect() end

---@return boolean success
---@return table|nil data
function turtle.inspectUp() end

---@return boolean success
---@return table|nil data
function turtle.inspectDown() end

---@param slot number
---@return boolean success
function turtle.select(slot) end

---@return number
function turtle.getSelectedSlot() end

---@param slot? number
---@return number
function turtle.getItemCount(slot) end

---@param slot? number
---@return table|nil
function turtle.getItemDetail(slot) end

---@param count? number
---@return boolean success
function turtle.transferTo(slot, count) end

---@param count? number
---@return boolean success
function turtle.drop(count) end

---@param count? number
---@return boolean success
function turtle.dropUp(count) end

---@param count? number
---@return boolean success
function turtle.dropDown(count) end

---@param count? number
---@return boolean success
function turtle.suck(count) end

---@param count? number
---@return boolean success
function turtle.suckUp(count) end

---@param count? number
---@return boolean success
function turtle.suckDown(count) end

---@param count? number
---@return boolean success
function turtle.refuel(count) end

---@return number|string
function turtle.getFuelLevel() end

---@return number
function turtle.getFuelLimit() end

---@return boolean success
function turtle.equipLeft() end

---@return boolean success
function turtle.equipRight() end
