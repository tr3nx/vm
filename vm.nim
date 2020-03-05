# HVM

type
  OpCode = enum
    False,
    True,
    Add,
    Sub,
    Mul,
    Div,
    Gt,
    Lt,
    Eq,
    Push,
    Pop,
    Store,
    Fetch,
    Jump,
    JumpFalse,
    JumpTrue,


proc run(ops: seq[int]): int =
  var ip: int
  var op: OpCode
  var stack: seq[int]
  var memory: array[10, int]

  while ip < ops.len:
    op = OpCode(ops[ip])
    inc(ip)

    case op
    of True:
      stack.add 1

    of False:
      stack.add 0

    of Add:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      stack.add a + b

    of Sub:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      stack.add b - a

    of Mul:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      stack.add a * b

    of Div:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      var q = a div b # quoient
      var r = a mod b # remainder
      stack.add r
      stack.add q

    of Gt:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      if a > b:
        stack.add ord(True)
      else:
        stack.add ord(False)

    of Lt:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      if a < b:
        stack.add ord(True)
      else:
        stack.add ord(False)

    of Eq:
      var a = stack.pop
      inc(ip)
      var b = stack.pop
      inc(ip)
      if a == b:
        stack.add ord(True)
      else:
        stack.add ord(False)

    of Push:
      stack.add ops[ip]
      inc(ip)

    of Pop:
      discard stack.pop
      inc(ip)

    of Store:
      memory[stack.pop] = stack.pop
      inc(ip)
      inc(ip)

    of Fetch:
      stack.add memory[stack.pop]
      inc(ip)

    of Jump:
      inc(ip)
      ip = ops[ip]

    of JumpTrue:
      inc(ip)
      if ops[ip] == ord(True):
        inc(ip)
        ip = ops[ip]
      inc(ip)

    of JumpFalse:
      inc(ip)
      if ops[ip] == ord(False):
        inc(ip)
        ip = ops[ip]
      inc(ip)




  result = stack.pop

echo @[ 9
      , 10
      , 9
      , 20
      , 2
      ].run()
