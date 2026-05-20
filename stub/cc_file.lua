---@meta

---@class file
local file = {}

---@return string|nil
function file.readLine() end

---@return string
function file.readAll() end

---@return string|nil
function file.read() end

---@param text string
function file.write(text) end

---@param text string
function file.writeLine(text) end

function file.flush() end

function file.close() end
