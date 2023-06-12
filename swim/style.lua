--[[
List of plates is taken from plates folder, so, to add one, just put a bunch of files
(diffuse texture, normals texture and, if needed, small script redefining some params)
to plates folder.
]]

-- let’s scan for all backgrounds we can find
plates = {}
for i, file in ipairs(fs.readDir('plates', '*.png')) do
  if file:find('.png') then
    name = path.getFileNameWithoutExtension(file)
    plates[name] = name
  end
end

-- input params:
defineSelect('Type', plates, nil)
defineText('Value', 6, InputLength.Fixed, nil)

return function(state, value)
  -- number plate params
  plate.size = { 1024, 540 }
  plate.sizeMultipler = 1.0 -- change it to 1.0 if you want to get 1024×540 textures
  plate.background = 'plates/' .. state .. '.png'
  plate.normals = 'plates/' .. state .. '.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.font = 'Acronym ExtraBold Italic.ttf'
  text.color = '#ffffff'
  text.size = 240
  text.weight = FontWeight.Normal
  text.lineSpacing = 49
  text.kerning = 5
  text.spaces = 0

  -- load params and enable or disable text
  offset = { x = 0, y = 21 }
  stateParams = 'plates/' .. state .. '.lua'
  if fs.exists(stateParams) then loadfile(stateParams)() end
  if disable_text then
	return
   end
  
  drawText(value:sub(1, 3) .. ' ' .. value:sub(4), offset.x, offset.y, Gravity.Center)
end