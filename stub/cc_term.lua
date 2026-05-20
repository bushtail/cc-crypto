---@meta

---@class term
term = term or {}

function term.clear() end

function term.clearLine() end

---@param x number
---@param y number
function term.setCursorPos(x, y) end

---@return number x
---@return number y
function term.getCursorPos() end

---@param text string
function term.write(text) end

---@param lines number
function term.scroll(lines) end

---@param blink boolean
function term.setCursorBlink(blink) end

---@return number width
---@return number height
function term.getSize() end

---@param color number
function term.setTextColor(color) end

---@param color number
function term.setBackgroundColor(color) end

