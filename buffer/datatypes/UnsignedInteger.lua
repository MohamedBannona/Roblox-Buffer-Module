local module = {}

local Shared = require(script.Parent.Parent.shared)

local U32Shift = Shared.U32Shift
local UpdateBuffer = Shared.UpdateBuffer

---------------Read---------------
--[[
	Reads an 8 bit unsigned integer (1 byte) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadU8(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 1); return 0 end
	return buffer.readu8(self.Buffer, Offset)
end

--[[
	Reads a 16 bit unsigned integer (2 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadU16(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 2); return 0 end
	return buffer.readu16(self.Buffer, Offset)
end

--[[
	Reads a 32 bit unsigned integer (4 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadU32(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4); return 0 end
	return buffer.readu32(self.Buffer, Offset)
end

--[[
	Reads a 64 bit unsigned integer (4 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read

	</br>**NOTE** Numbers start to lose presicion after reaching a certain limit
]]
function module:ReadU64(Offset): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8); return 0 end

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
	if not self.Buffer then self.Buffer = buffer.create(Offset + 1) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 1)

	buffer.writeu8(self.Buffer, Offset, Value)
end

--[[
	Writes a 16 bit unsigned integer (2 bytes) to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteU16(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(Offset + 2) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 2)

	buffer.writeu16(self.Buffer, Offset, Value)
end

--[[
	Writes a 32 bit unsigned integer (2 bytes) to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteU32(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4) end

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
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	local high = Value//U32Shift

	buffer.writeu32(self.Buffer, Offset, Value)
	buffer.writeu32(self.Buffer, Offset + 4, high)
end

return module