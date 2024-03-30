local module = {}

local Shared = require(script.Parent.Parent.shared)

local I32Shift = Shared.I32Shift
local UpdateBuffer = Shared.UpdateBuffer

--------------Read---------------
--[[
	Reads an 8 bit signed integer (1 byte) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadI8(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 1); return 0 end
	return buffer.readi8(self.Buffer, Offset)
end

--[[
	Reads a 16 bit signed integer (2 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadI16(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 2); return 0 end
	return buffer.readi16(self.Buffer, Offset)
end

--[[
	Reads a 32 bit signed integer (4 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read
]]
function module:ReadI32(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4); return 0 end
	return buffer.readi32(self.Buffer, Offset)
end

--[[
	Reads a 64 bit signed integer (8 bytes) starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@return [number] the number that has been read

	</br>**NOTE** Numbers start to lose presicion after reaching a certain limit
]]
function module:ReadI64(Offset): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8); return 0 end

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
	if not self.Buffer then self.Buffer = buffer.create(Offset + 1) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 1)

	buffer.writei8(self.Buffer, Offset, Value)
end

--[[
	Writes a 16 bit (2 bytes) signed integer to the buffer starting after `Offset`
	@param Value [number] the number to be written
	@param Offset [number] where to start writing from after
]]
function module:WriteI16(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(Offset + 2) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 2)

	buffer.writei16(self.Buffer, Offset, Value)
end

--[[
	Writes a 32 bit (4 bytes) signed integer to the buffer starting after `Offset`
	@param Value [number] the number to be written
	@param Offset [number] where to start writing from after
]]
function module:WriteI32(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4) end

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
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8) end
	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	local high = Value//I32Shift

	buffer.writei32(self.Buffer, Offset, Value)
	buffer.writei32(self.Buffer, Offset + 4, high)
end

return module