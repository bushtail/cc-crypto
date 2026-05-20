---@meta

---@class peripheral
peripheral = peripheral or {}

---@param side string
---@return table|nil
function peripheral.wrap(side) end

---@param side string
---@return boolean
function peripheral.isPresent(side) end

---@param side string
---@return string|nil
function peripheral.getType(side) end

---@return string[]
function peripheral.getNames() end

---@param name string
---@return string[]
function peripheral.getMethods(name) end

---@param side string
---@param method string
---@param ... any
---@return any
function peripheral.call(side, method, ...) end

---@param type string
---@param filter? fun(name: string, wrapped: table): boolean
---@return table ...
function peripheral.find(type, filter) end
