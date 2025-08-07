Utils = {}
Utils.__index = Utils

function Utils.dump(tbl, indent_level)
    indent_level = indent_level or 0
    local indent = string.rep(" ", indent_level)
    
    io.write(indent .. "{\n")
    for k, v in pairs(tbl) do
        io.write(indent .. " " .. tostring(k) .. " = ")
        if type(v) == "table" then
            Utils.dump(v, indent_level + 1)
        else
            io.write(tostring(v) .. ",\n")
        end
    end
    io.write(indent .. "},\n")
end

function Utils.filter( arr, predicate )
    local result = {}
    for i, v in ipairs(arr) do
        if predicate(v) then
            table.insert(arr, i)
        end
    end
    return result
end


return Utils