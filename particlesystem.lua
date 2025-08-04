local Particle = require("particle")
local Utils = require("utils")
local Vec = require("vector")

local ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem.new()
    local self = setmetatable({}, ParticleSystem)
    self.particles = {}
    return self
end

function ParticleSystem:add(particle)
    local gravity = Vec.createVector(0, 0.1)
    particle:applyForce(gravity)
    self.particles[#self.particles + 1] = particle
end

function ParticleSystem:update(dt)
    for _, particle in ipairs(self.particles) do
        particle:update(dt)
    end
end

function ParticleSystem:draw()
    if #self.particles > 0 then
        for i, particle in ipairs(self.particles) do
            particle:draw()
            if (particle:isDead()) then
                table.remove(self.particles, i)
            end
        end
    end
end

return ParticleSystem