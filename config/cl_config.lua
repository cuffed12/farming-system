cl_config = {}
cl_config.language = 'de' -- de, en

cl_config.zonen = {
    ['test'] = { -- farming name
        coords = vector3(1141.38, 69.21, 80.76), -- farming coords 
        markerdist = 25.0, -- marker distanz
        farmdist = 5.0, -- farming distanz
        item = 'veuqx', -- item name example: wood
        blip = { -- blip settings 
            id = 126, -- blip id
            size = 1.0, -- blip size
            color = 0, -- blip color
            name = 'veuqx' -- blip name 
        },
        marker = { -- marker settings 
            typ = 1, -- marker typ
            size = 1.0, -- marker size
            color = { -- marker color
                r = 0, 
                g = 0, 
                b = 0,
                t = 200
            }
        }
    }
}