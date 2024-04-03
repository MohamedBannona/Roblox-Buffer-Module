--[[
	Roblox Buffer Module, wrapper for the Roblox buffer
	Copyright (C) 2024  Mohamed Bannona

	This software is released under the CC0 1.0 Universal license.
]]
--[[
	Roblox Buffer Module V 1.2.1
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

export type Buffer = {
	Length: (self: Buffer) -> number,
	Merge: (self: Buffer, Buffer: buffer) -> Buffer,
	Get: (self: Buffer) -> buffer,
	ToString: (self: Buffer) -> string,
	--------------------------------------------------
	ReadU8: (self: Buffer, Offset: number) -> number,
	ReadU16: (self: Buffer, Offset: number) -> number,
	ReadU32: (self: Buffer, Offset: number) -> number,
	ReadU64: (self: Buffer, Offset: number) -> number,
	ReadF32: (self: Buffer, Offset: number) -> number,
	ReadF64: (self: Buffer, Offset: number) -> number,
	ReadString: (self: Buffer, Offset: number, Count: number) -> string,
	ReadI8: (self: Buffer, Offset: number) -> number,
	ReadI16: (self: Buffer, Offset: number) -> number,
	ReadI32: (self: Buffer, Offset: number) -> number,
	ReadI64: (self: Buffer, Offset: number) -> number,
	ReadVector3: (self: Buffer, Offset: number) -> Vector3,
	ReadVector3int16: (self: Buffer, Offset: number) -> Vector3int16,
	ReadVector2: (self: Buffer, Offset: number) -> Vector2,
	ReadVector2int16: (self: Buffer, Offset: number) -> Vector2int16,
	ReadUdim: (self: Buffer, Offset: number) -> UDim,
	ReadUdim2: (self: Buffer, Offset: number) -> UDim2,
	ReadColor3: (self: Buffer, Offset: number) -> Color3,
	--------------------------------------------------
	WriteU8: (self: Buffer, Value: number, Offset: number) -> (),
	WriteU16: (self: Buffer, Value: number, Offset: number) -> (),
	WriteU32: (self: Buffer, Value: number, Offset: number) -> (),
	WriteU64: (self: Buffer, Value: number, Offset: number) -> (),
	WriteF32: (self: Buffer, Value: number, Offset: number) -> (),
	WriteF64: (self: Buffer, Value: number, Offset: number) -> (),
	WriteString: (self: Buffer, Value: string, Offset: number) -> (),
	WriteI8: (self: Buffer, Value: number, Offset: number) -> (),
	WriteI16: (self: Buffer, Value: number, Offset: number) -> (),
	WriteI32: (self: Buffer, Value: number, Offset: number) -> (),
	WriteI64: (self: Buffer, Value: number, Offset: number) -> (),
	WriteVector3: (self: Buffer, Value: Vector3, Offset: number) -> (),
	WriteVector3int16: (self: Buffer, Value: Vector3int16, Offset: number) -> (),
	WriteVector2: (self: Buffer, Value: Vector2, Offset: number) -> (),
	WriteVector2int16: (self: Buffer, Value: Vector2int16, Offset: number) -> (),
	WriteUdim: (self: Buffer, Value: UDim, Offset: number) -> (),
	WriteUdim2: (self: Buffer, Value: UDim2, Offset: number) -> number,
	WriteColor3: (self: Buffer, Value: Color3, Offset: number) -> ()
}

local module = {}
module.__index = module
module.__tostring = function(self)
	return buffer.tostring(self.Buffer)
end

--[[
	Returns a new buffer of size `Size` or 1
	@param Size [number] Initial size in bytes of the Buffer
]]
function module.new(Size): Buffer
	return setmetatable({Buffer = buffer.create(Size or 1)}, module):: any
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
function module:Merge(Buffer: buffer): Buffer
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
function module.FromString(String: string): Buffer
	local buff = buffer.fromstring(String)

	return module.FromBuffer(buff)
end

--[[
	Creates a new buffer object using the provided buffer type
	@param Buffer [buffer] the buffer to create with
]]
function module.FromBuffer(Buffer: buffer): Buffer
	return setmetatable({Buffer = Buffer}, module):: any
end

for _, mod in script.datatypes:GetChildren() do
	for i, v in require(mod) do
		module[i] = v
	end
end

return module
