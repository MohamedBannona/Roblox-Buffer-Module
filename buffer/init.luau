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
	This module is just a wrapper for the roblox buffer object with support for U64 and I64 (imprecise)
	If roblox adds support for 64 bit numbers in buffers, this module will become obsolete, please do not use it then

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

local I32Shift = 2147483647 -- 2^31
local U32Shift = 4294967295 -- 2^32

local function UpdateBuffer(Buffer: buffer, Offset: number, Size: number?)
	local length = buffer.len(Buffer)
	local requiredSize = Offset + (Size or 0)

	if length < requiredSize then
		local newBuffer = buffer.create(requiredSize)
		buffer.copy(newBuffer, 0, Buffer)

		return newBuffer
	end

	return Buffer
end

--[[
	Returns a new buffer of size `Size` or 1
	@param Size [number] Initial size in bytes of the Buffer
]]
function module.new(Size)
	return setmetatable({Buffer = buffer.create(Size or 1)}, module)
end
---------Signed Integers---------
--------------Read---------------
--[[
	Reads an 8 bit signed integer (1 byte) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadI8(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(1) return 0 end
	return buffer.readi8(self.Buffer, Offset)
end

--[[
	Reads a 16 bit signed integer (2 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadI16(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(2) return 0 end
	return buffer.readi16(self.Buffer, Offset)
end

--[[
	Reads a 32 bit signed integer (4 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadI32(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(4) return 0 end
	return buffer.readi32(self.Buffer, Offset)
end

--[[
	Reads a 64 bit signed integer (8 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read

	</br>**NOTE** Numbers start to lose presicion after reaching a certain limit
]]
function module:ReadI64(Offset): number
	if not self.Buffer then self.Buffer = buffer.create(8) return 0 end

	local low = buffer.readi32(self.Buffer, Offset)
	local high = buffer.readi32(self.Buffer, Offset + 4)

	return low + high * I32Shift
end

---------Write---------
--[[
	Writes an 8 bit (1 byte) signed integer to the buffer starting after `Offset`
	@param Value [number] the number to be written
	@param Offset [number] where to start writing from after
]]
function module:WriteI8(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(1) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 1)

	buffer.writei8(self.Buffer, Offset, Value)
end

--[[
	Writes a 16 bit (2 bytes) signed integer to the buffer starting after `Offset`
	@param Value [number] the number to be written
	@param Offset [number] where to start writing from after
]]
function module:WriteI16(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(2) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 2)

	buffer.writei16(self.Buffer, Offset, Value)
end

--[[
	Writes a 32 bit (4 bytes) signed integer to the buffer starting after `Offset`
	@param Value [number] the number to be written
	@param Offset [number] where to start writing from after
]]
function module:WriteI32(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(4) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 4)

	buffer.writei32(self.Buffer, Offset, Value)
end

--[[
	Writes a 64 bit (8 byte) signed integer to the buffer starting after `Offset`
	@param Value [number] the number to be written
	@param Offset [number] where to start writing from after

	</br>**NOTE** Numbers start to lose presicion after reaching a certain limit
]]
function module:WriteI64(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(8) end
	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	local high = Value//I32Shift

	buffer.writei32(self.Buffer, Offset, Value)
	buffer.writei32(self.Buffer, Offset + 4, high)
end

---------Unigned Integers---------
---------------Read---------------
--[[
	Reads an 8 bit unsigned integer (1 byte) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadU8(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(1) return 0 end
	return buffer.readu8(self.Buffer, Offset)
end

--[[
	Reads a 16 bit unsigned integer (2 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadU16(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(2) return 0 end
	return buffer.readu16(self.Buffer, Offset)
end

--[[
	Reads a 32 bit unsigned integer (4 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadU32(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(4) return 0 end
	return buffer.readu32(self.Buffer, Offset)
end

--[[
	Reads a 64 bit unsigned integer (4 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read

	</br>**NOTE** Numbers start to lose presicion after reaching a certain limit
]]
function module:ReadU64(Offset): number
	if not self.Buffer then self.Buffer = buffer.create(8) return 0 end

	local low = buffer.readu32(self.Buffer, Offset)
	local high = buffer.readu32(self.Buffer, Offset + 4)

	return low + high * U32Shift
end

---------Write---------
--[[
	Writes an 8 bit unsigned integer (1 bytes) to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteU8(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(1) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 1)

	buffer.writeu8(self.Buffer, Offset, Value)
end

--[[
	Writes a 16 bit unsigned integer (2 bytes) to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteU16(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(2) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 2)

	buffer.writeu16(self.Buffer, Offset, Value)
end

--[[
	Writes a 32 bit unsigned integer (2 bytes) to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteU32(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(4) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 4)

	buffer.writeu32(self.Buffer, Offset, Value)
end

--[[
	Writes a 64 bit unsigned integer (4 bytes) to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Value [number] the number to be written to the buffer

	</br>**NOTE** Numbers start to lose presicion after reaching a certain limit
]]
function module:WriteU64(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(8) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	local high = Value//U32Shift

	buffer.writeu32(self.Buffer, Offset, Value)
	buffer.writeu32(self.Buffer, Offset + 4, high)
end

---------Float 32---------
--[[
	Reads a 32 bit (4 bytes) floating point number starting after `Offst`
	@param Offset [number] where to start reading from after
	@return [number] the number that was read
]]
function module:ReadF32(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(4) return 0 end

	return buffer.readf32(self.Buffer, Offset)
end

--[[
	Write a 32 bit (4 bytes) floating point number starting to the buffer starting after `Offst`
	@param Offset [number] where to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteF32(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(4) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 4)

	return buffer.readf32(self.Buffer, Offset)
end

---------Float 64---------
--[[
	Reads a 64 bit (8 bytes) floating point number starting after `Offst`
	@param Offset [number] where to start reading from after
	@return [number] the number that was read
]]
function module:ReadF64(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(8) return 0 end

	return buffer.readf64(self.Buffer, Offset)
end

--[[
	Write a 64 bit (8 bytes) floating point number starting to the buffer starting after `Offset`
	@param Offset [number] where to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteF64(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(8) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	return buffer.writef64(self.Buffer, Offset, Value)
end

---------String---------
--[[
	Writes string to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param String [string] the string to be written to the buffer
]]
function module:WriteString(String: string, Offset: number)
	local count = string.len(self)

	if not self.Buffer then self.Buffer = buffer.create(count + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, count)

	buffer.writestring(self.Buffer, Offset, String, count)
end

--[[
	Reads string from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@param Count [number] how many bytes to read the string from after `Offset`
	@return [string] the string that has been read
]]
function module:ReadString(Offset: number, Count: number): string
	if not self.Buffer then self.Buffer = buffer.create(Count + Offset) return "" end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, Count)

	return buffer.readstring(self.Buffer, Offset, Count)
end

---------Other---------
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

return module
