local Vector = require("vector")

local Shape = {}
Shape.__index = Shape

function Shape.dimension(w, h)
    local self = setmetatable({
        width = w,
        height = h
    }, Shape)
    return self    
end

Shape.RectangularShape = {}
Shape.RectangularShape.__index = Shape.RectangularShape

function Shape.RectangularShape.new(x, y, w, h)
    local self = setmetatable({}, Shape.RectangularShape)
    self.position = Vector.createVector(x, y)
    self.dimension = Shape.dimension(w, h)
    return self
end

function Shape.RectangularShape.collitionWithOtherShape(rectShape1, rectShape2)
    local isCollide = false
    if (rectShape1.position.x < rectShape2.position.x + rectShape2.dimension.width and
        rectShape1.position.x + rectShape1.dimension.width > rectShape2.position.x and
        rectShape1.position.y < rectShape2.position.x + rectShape2.dimension.height and
        rectShape1.position.y + rectShape1.height > rectShape2.position.y) then
        isCollide = true
    end

    return isCollide
end


Shape.CircularShape = {}
Shape.CircularShape.__index = Shape.CircularShape

function Shape.CircularShape.new(x, y, radius)
    local self = setmetatable({}, Shape.CircularShape)
    self.position = Vector.createVector(x, y)
    self.radius = radius or 16
    return self
end

function Shape.CircularShape.collitionWithOtherShape(cirShape1, cirShape2)
   local dx = (cirShape1.position.x + cirShape1.radius) - (cirShape2.position.x + cirShape2.radius)
   local dy = (cirShape1.position.y + cirShape1.radius) - (cirShape2.position.y + cirShape2.radius)

   local radiisSum = cirShape1.radius + cirShape2.radius
   local distance = math.sqrt(dx * dx + dy * dy)

   return distance < radiisSum

end

return Shape