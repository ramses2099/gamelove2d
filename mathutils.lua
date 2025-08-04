local MathUtils = {}
MathUtils.__index = MathUtils


-- A simple helper function to constrain a value within a min and max range.
-- This is a common pattern to "clamp" values and is crucial for stability.
-- @param value The number to constrain.
-- @param min The minimum allowed value.
-- @param max The maximum allowed value.
-- @return The constrained number.
function MathUtils.contrain(value, min, max)
    return math.min(math.max(value, min), max)
end



return MathUtils