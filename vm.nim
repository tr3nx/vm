# Stack Machine using Nim lang

type
  OpCode = enum
    False,     # 0
    True,      # 1
    Add,       # 2
    Sub,       # 3
    Mul,       # 4
    Div,       # 5
    Mod,       # 6
    Gt,        # 7
    Lt,        # 8
    Eq,        # 9
    Push,      # 10
    Pop,       # 11
    Nop,       # 12
    Store,     # 13
    Fetch,     # 14
    Jump,      # 15
    JumpTrue,  # 16
    JumpFalse, # 17
    Call,      # 18
    Arg,       # 19
    Ret,       # 20
    Print,     # 21
    Halt,      # 22

proc run(ops: seq[int], entry: int = 0, debug: bool = false): int =
  var
    ip: int = entry
    fp: int
    op: OpCode
    stack: seq[int]
    memory: array[0, int]

  while ip < ops.len:
    op = OpCode(ops[ip])
    inc(ip)

    case op
    of False: # 0
      stack.add 0

    of True: # 1
      stack.add 1

    of Add: # 2
      var
        b = stack.pop
        a = stack.pop
      stack.add a + b

    of Sub: # 3
      var
        b = stack.pop
        a = stack.pop
      stack.add a - b

    of Mul: # 4
      var
        b = stack.pop
        a = stack.pop
      stack.add a * b

    of Div: # 5
      var
        b = stack.pop
        a = stack.pop
        q = a div b # quoient
      stack.add q
      # var r = a mod b # remainder
      # stack.add r

    of Mod: # 6
      var
        b = stack.pop
        a = stack.pop
        r = a mod b # remainder
      stack.add r

    of Gt: # 7
      var
        b = stack.pop
        a = stack.pop
      if a > b:
        stack.add ord(True)
      else:
        stack.add ord(False)

    of Lt: # 8
      var
        b = stack.pop
        a = stack.pop
      if a < b:
        stack.add ord(True)
      else:
        stack.add ord(False)

    of Eq: # 9
      var
        b = stack.pop
        a = stack.pop
      if a == b:
        stack.add ord(True)
      else:
        stack.add ord(False)

    of Push: # 10
      stack.add ops[ip]
      inc(ip)

    of Pop: # 11
      discard stack.pop

    of Nop: # 12
      inc(ip)

    of Store: # 13
      memory[stack.pop] = stack.pop

    of Fetch: # 14
      stack.add memory[stack.pop]

    of Jump: # 15
      ip = ops[ip]

    of JumpTrue: # 16
      if stack.pop == ord(True):
        ip = ops[ip]
      else:
        inc(ip)

    of JumpFalse: # 17
      if stack.pop == ord(False):
        ip = ops[ip]
      else:
        inc(ip)

    of Call: # 18
      var address = ops[ip]
      inc(ip)

      stack.add ops[ip] # argc
      inc(ip)

      stack.add fp
      stack.add ip

      fp = stack.len - 1
      ip = address

    of Arg: # 19
      stack.add stack[(fp - 3) - ops[ip]]
      inc(ip)

    of Ret: # 20
      var returned = stack.pop
      ip = stack.pop
      fp = stack.pop

      # pop args
      for _ in countup(1, stack.pop):
        discard stack.pop

      stack.add returned

    of Print: # 21
      echo stack[stack.len - 1]

    of Halt: # 22
      break

    if debug:
      echo "---------------------"
      echo " ip = ", ip, " | fp = ", fp
      echo "    Code | ", $op, " (", $(ord(op) - 1), ")"
      echo "   Stack | ", $stack
      echo "  Memory | ", $memory
      echo ""

  result = stack.pop


# main

# proc fact(n: int): int =
#   return if n < 2: 1
#              else: n * fact(n - 1)

echo @[
      # if n < 2: 1 else:
        ord(Arg)       # 0
      , 0              # 1
      , ord(Push)      # 2
      , 2              # 3
      , ord(Lt)        # 4
      , ord(JumpFalse) # 5
      , 10             # 6
      , ord(Push)      # 7
      , 1              # 8
      , ord(Ret)       # 9

      # n * fact(n - 1)
      , ord(Arg)       # 10
      , 0              # 11
      , ord(Arg)       # 12
      , 0              # 13
      , ord(Push)      # 14
      , 1              # 15
      , ord(Sub)       # 16
      , ord(Call)      # 17
      , 0              # 18
      , 1              # 19
      , ord(Mul)       # 20
      , ord(Ret)       # 21

      # proc fact(n: int): int
      , ord(Push)      # 22 - entry
      , 2              # 23 - input value
      , ord(Call)      # 24
      , 0              # 25
      , 1              # 26
      ].run( entry = 22
           , debug = true)
