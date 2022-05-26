Celula = {
    status = false,
    x = 0,
    y = 0,
}

function Celula:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end


function Celula:draw()
    if self.status == true then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(0, 0, 0)
    end

    love.graphics.rectangle("fill", self.x, self.y, 10, 10)
end

