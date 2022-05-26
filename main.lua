-- Reglas
-- 1 - Una célula muerta con exactamente 3 células vecinas vivas "nace"
--     (es decir, al turno siguiente estará viva).

-- 2 - Una célula viva con 2 o 3 células vecinas vivas sigue viva, en
--     otro caso muere (por "soledad" o "superpoblación").


require "Celula"

function love.load()
    -- tamanios de las celulas
    local cell_size = 7
    
    local cell_x = love.graphics.getWidth() / cell_size
    local cell_y = love.graphics.getHeight() / cell_size


    cells = {}
    for i = 1, cell_x do
        cells[i] = {}
        for j = 1, cell_y do
            cells[i][j] = Celula:new{
                status = false,
                x = (i - 1) * cell_size,
                y = (j - 1) * cell_size,
            }
        end
    end
end

function vecinos(i, j)
    local neighbors = 0

    if i > 1 and cells[i - 1][j].status then
        neighbors = neighbors + 1
    end

    if i < #cells and cells[i + 1][j].status then
        neighbors = neighbors + 1
    end

    if j > 1 and cells[i][j - 1].status then
        neighbors = neighbors + 1
    end

    if j < #cells[i] and cells[i][j + 1].status then
        neighbors = neighbors + 1
    end

    if i > 1 and j > 1 and cells[i - 1][j - 1].status then
        neighbors = neighbors + 1
    end

    if i > 1 and j < #cells[i] and cells[i - 1][j + 1].status then
        neighbors = neighbors + 1
    end

    if i < #cells and j > 1 and cells[i + 1][j - 1].status then
            neighbors = neighbors + 1
    end

    if i < #cells and j < #cells[i] and cells[i + 1][j + 1].status then
            neighbors = neighbors + 1
    end

    return neighbors
end

function love.update(dt)

    for i = 1, #cells do
        for j = 1, #cells[i] do
            local celula = cells[i][j]
            local neighbors = vecinos(i, j)


            if celula.status == true and neighbors < 2 or neighbors > 3 then
                celula.status = false
            elseif neighbors == 3 then
                celula.status = true
            end
        end
    end

end



function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        local cell_x = x / 7
        local cell_y = y / 7
        
        
        cell_x = math.floor(cell_x)
        cell_y = math.floor(cell_y)

        cells[cell_x][cell_y].status = true
        cells[cell_x][cell_y + 1].status = true
        cells[cell_x + 1][cell_y].status = true
        cells[cell_x + 1][cell_y + 1].status = true
    end

    if button == 2 then
        for i = 1, #cells do
            for j = 1, #cells[i] do
                cells[i][j].status = false
            end
        end
    end
end

function love.draw()
    
    for i = 1, #cells do
        for j = 1, #cells[i] do
            cells[i][j]:draw()
        end
    end

end
