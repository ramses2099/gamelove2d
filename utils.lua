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

return Utils