---@meta

---@class fs
fs = fs or {}

---@param path string
---@return string[]
function fs.list(path) end

---@param path string
---@return boolean
function fs.exists(path) end

---@param path string
---@return boolean
function fs.isDir(path) end

---@param path string
---@return boolean
function fs.isReadOnly(path) end

---@param path string
---@return number
function fs.getSize(path) end

---@param path string
---@return number
function fs.getFreeSpace(path) end

---@param path string
function fs.makeDir(path) end

---@param path string
function fs.delete(path) end

---@param from string
---@param to string
function fs.copy(from, to) end

---@param from string
---@param to string
function fs.move(from, to) end

---@param base string
---@param localPath string
---@return string
function fs.combine(base, localPath) end

---@param path string
---@return string
function fs.getName(path) end

---@param path string
---@return string
function fs.getDir(path) end

---@param path string
---@param mode '"r"'|'"w"'|'"a"'|'"rb"'|'"wb"'|'"ab"'
---@return file|nil
function fs.open(path, mode) end
