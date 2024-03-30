--[[
	Roblox Buffer Module, wrapper for the Roblox buffer
	Copyright (C) 2024  Mohamed Bannona

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]
--[[
	Roblox Buffer Module V 1.0.0
	This module is just a wrapper for the roblox buffer object with support for U64 and I64 with support for other datatypes (imprecise)

	Usage:
	```lua
		--Example 1
		local BufferModule = require(Path.To.Module)

		local Buff = BufferModule.new(1024) --1 kilobyte is too much for most cases

		local String = "Hello World!"
		local Length = #String

		--Writing starts AFTER the offset
		Buff:WriteU16(Length, 0)
		Buff:WriteString(String, 2)

		print(Buff:ReadString(2, Buff:ReadU16(0))) --Hello World!

		--You could also use Buff:Get() to get the actual buffer object
		print(buffer.readstring(Buff.Buffer, 0, Length)) --Hello World!

		--Example 2
		local BufferModule = require(Path.To.Module)

		local buff = BufferModule.FromBuffer(DataStore:GetAsync("Editors"))
		
		local Start = 0
		for i = 0, buff:Length(), 12 do
			local Id = Buff:ReadF64(i)
			local End = Buff:ReadU32(i+8)

			print(`{Players:GetNameFromUserIdAsync(Id)} Edited from {Start} to {End}`)

			Start = End + 1
		end
	```

	For more info about the buffer object, see https://create.roblox.com/docs/reference/engine/libraries/buffer
]]

local module = {}
module.__index = module
module.__tostring = function(self)
	return buffer.tostring(self.Buffer)
end

--[[
	Returns a new buffer of size `Size` or 1
	@param Size [number] Initial size in bytes of the Buffer
]]
function module.new(Size)
	return setmetatable({Buffer = buffer.create(Size or 1)}, module)
end

--[[
	Returns the length of the buffer
]]
function module:Length()
	return buffer.len(self.Buffer)
end

--[[
	Merges two buffers together
	@param Buffer [buffer] the buffer to merge with
]]
function module:Merge(Buffer: buffer)
	local newS = buffer.len(self.Buffer) + buffer.len(Buffer)
	local newBuffer = buffer.create(newS)
	buffer.copy(newBuffer, 0, self.Buffer)
	buffer.copy(newBuffer, buffer.len(self.Buffer), Buffer)

	return module.FromBuffer(newBuffer)
end

--[[
	Returns the actual buffer object used to store data
]]
function module:Get()
	return self.Buffer
end

--[[
	Creates a new buffer who's bytes make up the string
	@param String [string] the string to create the buffer from
]]
function module.FromString(String: string)
	local buff = buffer.fromstring(String)

	return module.FromBuffer(buff)
end

--[[
	Creates a new buffer object using the provided buffer type
	@param Buffer [buffer] the buffer to create with
]]
function module.FromBuffer(Buffer: buffer)
	return setmetatable({Buffer = Buffer}, module)
end

for _, mod in script.datatypes:GetChildren() do
	for i, v in require(mod) do
		module[i] = v
	end
end

return module
