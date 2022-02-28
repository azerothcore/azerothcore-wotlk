Smallfolk
=========

Smallfolk is a reasonably fast, robust, richtly-featured table serialization
library for Lua. It was specifically written to allow complex data structures
to be loaded from unsafe sources for [LÖVE](http://love2d.org/) games, but can
be used anywhere.

You use, distribute and extend Smallfolk under the terms of the MIT license.

Usage
-----

Smallfolk is very simple and easy to use:

```lua
local smallfolk = require 'smallfolk'

print(smallfolk.dumps({"Hello", world = true}))
print(smallfolk.loads('{"foo":"bar"}').foo)
-- prints:
-- {"Hello","world":t}
-- bar
```

Fast
----

Using Serpent's benchmark code, Smallfolk's serialization speed is comparable
to that of Ser (and Ser is 33% faster than Serpent).

It should be noted that deserialization is much slower in Smallfolk than in
most other serialization libraries, because it parses the input itself instead
of handing it over to Lua. However, if you use LuaJIT this difference is much
less, and it is not noticable for small outputs. By default, Smallfolk rejects
inputs that are too large, to prevent DOS attacks.

Robust
------

Sometimes you have strange, non-euclidean geometries in your table
constructions. It happens, I don't judge. Smallfolk can deal with that, where
some other serialization libraries (or anything that produces JSON) cry "Iä!
Iä! Cthulhu fhtagn!" and give up &mdash; or worse, silently produce incorrect
data.

```lua
local smallfolk = require 'smallfolk'

local cthulhu = {{}, {}, {}}
cthulhu.fhtagn = cthulhu
cthulhu[1][cthulhu[2]] = cthulhu[3]
cthulhu[2][cthulhu[1]] = cthulhu[2]
cthulhu[3][cthulhu[3]] = cthulhu
print(smallfolk.dumps(cthulhu))
-- prints:
-- {{{@2:@3}:{@4:@1}},@3,@4,"fhtagn":@1}
```

Secure
------

Smallfolk doesn't run arbitrary Lua code, so you can safely use it when you
want to read data from an untrusted source.

Compact
-------

Smallfolk creates really small output files compared to something like Ser when
it encounters a lot of non-tree-like data, by using numbered references rather
than item assignment.

Tested
------

Check out `tests.lua` to see how Smallfolk behaves with all kinds of inputs.

Reference
---------

###`smallfolk.dumps(object)`

Returns an 8-bit string representation of `object`. Throws an error if `object`
contains any types that cannot be serialised (userdata, functions and threads).

###`smallfolk.loads(string[, maxsize=10000])`

Returns an object whose representation would be `string`. If the length of
`string` is larger than `maxsize`, no deserialization is attempted and instead
an error is thrown. If `string` is not a valid representation of any object,
an error is thrown.

See also
--------

* [Ser](https://github.com/gvx/Ser): for trusted-source serialization
* [Lady](https://github.com/gvx/Lady): for trusted-source savegames
