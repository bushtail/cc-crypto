---@class csrng
local csrng = {}

local pool = {}
local counter = 0

function csrng.seed(value)
    pool[#pool + 1] = tostring(value)
end

function csrng.seedEvent(event, ...)
    csrng.seed(event)

    for i = 1, select("#", ...) do
        csrng.seed(select(i, ...))
    end
end

local function gather()
    csrng.seed(os.clock())
    csrng.seed(os.epoch("utc"))
    csrng.seed(os.time())
    csrng.seed(os.day())

    csrng.seed(tostring({}))
    csrng.seed(tostring(coroutine.running()))

    csrng.seed(os.getComputerID)

    local label = os.getComputerLabel
    if label then csrng.seed(label) end

    csrng.seed(fs.getFreeSpace("/"))

    local files = fs.list("/")
    csrng.seed(#files)
    for i = 1, #files do
        csrng.seed(files[i])
    end

    if term then
        local x, y = term.getCursorPos()
        local w, h = term.getSize()

        csrng.seed(x)
        csrng.seed(y)
        csrng.seed(w)
        csrng.seed(h)
    end

    if peripheral then
        local names = peripheral.getNames()

        csrng.seed(#names)

        for i = 1, #names do
            local side = names[i]
            csrng.seed(side)

            local ptype = peripheral.getType(side)
            if ptype then
                csrng.seed(type)
            end

            csrng.seed(side .. ":" .. (ptype or "unknown"))

            if peripheral.getMethods then
                local methods = peripheral.getMethods(side)

                if methods then
                    csrng.seed(#methods)
                    for j = 1, #methods do
                        csrng.seed(methods[j])
                    end
                end
            end
        end
    end

    if turtle then
        csrng.seed(turtle.getFuelLevel())
        csrng.seed(turtle.getSelectedSlot())

        for i = 1, 16 do
            csrng.seed(turtle.getItemCount(i))
        end
    end
end

local function extract()
    local data = table.concat(pool) .. tostring(counter)
    counter = counter + 1

    local hash = 0

    for i = 1, #data do
        hash = (hash + string.byte(data, i)) % 0x100000000
        hash = bits.bxor
    end
end
