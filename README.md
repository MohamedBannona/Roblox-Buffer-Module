# Roblox Buffer Module

Roblox Buffer Module V 1.2.1</br>
This module is just a wrapper for the roblox buffer object with support for U64 and I64 and other datatypes</br>

- [Usage](#example-usage)
- [Installation](#installation)
- [API Reference](#api-reference)
- [QnA](#qna)
- [Plans](#the-future)

## Example Usage:
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

## Installation
Using Rojo, simply add the module to your project and you're good to go!
Using Roblox, Insert a module script and paste the contents of [init.luau](./buffer/init.luau) into it

## API Reference
<details><summary><a href="#constructors">Constructors</a></summary>

- [new](#new)
- [FromBuffer](#FromBuffer)
- [FromString](#FromString)
</details>
<details><summary><a href="#general">General</a></summary>

- [Length](#Length)
- [Merge](#Merge)
- [Get](#Get)
- [tostring](#tostring)
</details>
<details><summary><a href="#read">Read</a></summary>
<details><summary><a href="#signed-integers">Signed Integers</a></summary>

- [ReadI8](#ReadI8)
- [ReadI16](#ReadI16)
- [ReadI32](#ReadI32)
- [ReadI64](#ReadI64)
</details>
<details><summary><a href="#unsigned-integers">Unsigned Integers</a></summary>

- [ReadU8](#ReadU8)
- [ReadU16](#ReadU16)
- [ReadU32](#ReadU32)
- [ReadU64](#ReadU64)
</details>
<details><summary><a href="#floats">Floats</a></summary>

- [ReadF32](#ReadF32)
- [ReadF64](#ReadF64)
</details>
<details><summary><a href="#vectors">Vectors</a></summary>

- [ReadVector3](#ReadVector3)
- [ReadVector3int16](#ReadVector3int16)
- [ReadVector2](#ReadVector2)
- [ReadVector2int16](#ReadVector2int16)
</details>
<details><summary><a href="#Udims">Udims</a></summary>

- [ReadUdim](#ReadUdim)
- [ReadUdim2](#ReadUdim2)
</details>

• [ReadString](#ReadString)
• [ReadColor3](#ReadColor3)
</details>
<details><summary><a href="#write">Write</a></summary>
<details>
<summary><a href="#signed-integers">Signed Integers</a></summary>

- [WriteI8](#WriteI8)
- [WriteI16](#WriteI16)
- [WriteI32](#WriteI32)
- [WriteI64](#WriteI64)
</details>
<details><summary><a href="#unsigned-integers">Unsigned Integers</a></summary>

- [WriteU8](#WriteU8)
- [WriteU16](#WriteU16)
- [WriteU32](#WriteU32)
- [WriteU64](#WriteU64)
</details>
<details><summary><a href="#floats">Floats</a></summary>

- [WriteF32](#WriteF32)
- [WriteF64](#WriteF64)
</details>
<details><summary><a href="#vectors">Vectors</a></summary>

- [WriteVector3](#WriteVector3)
- [ReadVector3int16](#WriteVector3int16)
- [WriteVector2](#WriteVector2)
- [WriteVector2int16](#WriteVector2int16)
</details>
<details><summary><a href="#Udims">Udims</a></summary>

- [WriteUdim](#WriteUdim)
- [WriteUdim2](#WriteUdim2)
</details>

• [WriteString](#WriteString)
• [WriteColor3](#WriteColor3)
</details>

## Constructors
### new
Create a new Buffer class with the provided size in bytes
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Size` | `number` | The size in bytes of the Buffer object | ❌ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

### FromBuffer
Create a new Buffer class from an existing buffer object
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Buffer` | `buffer` | The buffer object to use | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

### FromString
Create a new Buffer class from a string
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `String` | `string` | The string to use | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

## General
### Length
Returns the length of the buffer
| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Length` | `number` | The length of the buffer

### Merge
Merges two buffers together
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Buffer` | `buffer` | The buffer to merge | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

### Get
Returns the buffer object
| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `buffer` | The buffer object


## Read
## Signed Integers
### ReadI8
Reads an 8 bit signed integer (1 byte) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadI16
Reads a 16 bit signed integer (2 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadI32
Reads a 32 bit signed integer (4 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadI64
Reads a 64 bit signed integer (8 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

## Unsigned Integers
### ReadU8
Reads an 8 bit unsigned integer (1 byte) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadU16
Reads a 16 bit unsigned integer (2 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadU32
Reads a 32 bit unsigned integer (4 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadU64
Reads a 64 bit unsigned integer (8 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

## Floats
### ReadF32
Reads a 32 bit float (4 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadF64
Reads a 64 bit float (8 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

## Vectors
## ReadVector3
Read a Vector3 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading from after | ✅

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Vector` | `Vector3` | The Vector3 that has been read

## ReadVector3int16
Read a Vector3int16 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading from after | ✅

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Vector` | `Vector3` | The Vector3int16 that has been read

## ReadVector2
Read a Vector2int16 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading from after | ✅

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Vector` | `Vector2` | The Vector2 that has been read

## ReadVector2int16
Read a Vector2int16 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading from after | ✅

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Vector` | `Vector2int16` | The Vector2int16 that has been read

## Udim
## ReadUdim
Read a Udim to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading from after | ✅

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Udim` | `Udim` | The Udim that has been read

## ReadUdim2
Read a Udim2 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading from after | ✅

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Udim2` | `Udim2` | The Udim2 that has been read

## ReadString
Reads a string starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |
| `Length` | `number` | How many bytes to read | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `string` | `string` | The string that has been read

## ReadColor3
Reads a Color3 starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

## Write
## Signed Integers
### WriteI8
Writes an 8 bit signed integer (1 byte) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteI16
Writes a 16 bit signed integer (2 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteI32
Writes a 32 bit signed integer (4 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteI64
Writes a 64 bit signed integer (8 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

## Unsigned Integers
### WriteU8
Writes an 8 bit unsigned integer (1 byte) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteU16
Writes a 16 bit unsigned integer (2 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteU32
Writes a 32 bit unsigned integer (4 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteU64
Writes a 64 bit unsigned integer (8 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

## Floats
### WriteF32
Writes a 32 bit float (4 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteF64
Writes a 64 bit float (8 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## WriteString
Writes a string to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `string` | `string` | The string to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## Vectors
## WriteVector3
Writes a Vector3 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Vector` | `Vector3` | The Vector3 to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## WriteVector3int16
Writes a Vector3int16 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Vector` | `Vector3int16` | The Vector3int16 to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## WriteVector2
Writes a Vector2int16 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Vector` | `Vector2` | The Vector2 to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## WriteVector2int16
Writes a Vector2int16 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Vector` | `Vector2int16` | The Vector2int16 to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## Udims
## WriteUdim
Writes a Udim to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Udim` | `Udim` | The Udim to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## WriteUdim2
Writes a Udim2 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Udim2` | `Udim2` | The Udim2 to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

| Returns | Type     | Description                | Required |
| :------ | :------- | :------------------------- |
| `size` | `number` | The size in bytes that has been written to the buffer 

## WriteColor3
Writes a Color3 to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Color` | `Color3` | The Color3 to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## tostring
Converts each byte (or more) in the string to a character
There is no Buffer:Tostring() method, instead you use tostring(Buffer)
</br>

## QnA

#### When should I use this module?
-	When you want to store a wide range of datatypes easily with buffers

#### When should I not use this module?
- Always

#### Why use buffers over tables?
- buffers use less memory than number arrays and packing strings into and out of buffers is more performant than using string.pack()/unpack

#### Can I store instances in Buffers?
- No, numbers only (strings are stored as UTF-8), serialize.
</br>

## The Future
- Add support for other data types (Enums, Rects, Params(RaycastParams, OverlapParams), Cframes, etc.)
- Automatic Serialization and Deserialization for Instances
- FromTable Constructor
- Next Step: Enums (u16 for the actual Enum, u8 for the EnumItem)

</br>
You should try and estimate the total amount of data that's going to be stored in the buffer to decrease the amount of times new buffers have to be created
</br></br>

For more information on Roblox Buffers:
[API Reference](https://create.roblox.com/docs/reference/engine/libraries/buffer), [Devforum Post](https://devforum.roblox.com/t/introducing-luau-buffer-type-beta/2724894)