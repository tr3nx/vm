# Stack Machine using Nim lang


```
proc fact(n: int): int =
  return if n < 2: 1
             else: n * fact(n - 1)
```

```
# if n < 2: 1 else:
Arg       # 0
0         # 1
Push      # 2
2         # 3
Lt        # 4
JumpFalse # 5
10        # 6
Push      # 7
1         # 8
Ret       # 9

# n * fact(n - 1)
Arg       # 10
0         # 11
Arg       # 12
0         # 13
Push      # 14
1         # 15
Sub       # 16
Call      # 17
0         # 18
1         # 19
Mul       # 20
Ret       # 21

# proc fact(n: int): int
Push      # 22 - entry
2         # 23 - input value
Call      # 24
0         # 25
1         # 26
```

```
[tr3nx@box hvm]$ nim c -r vm.nim 
Hint: used config file '/etc/nim/nim.cfg' [Conf]
Hint: system [Processing]
Hint: widestrs [Processing]
Hint: io [Processing]
Hint: vm [Processing]
CC: vm.nim
Hint:  [Link]
Hint: operation successful (14708 lines compiled; 0.255 sec total; 20.742MiB peakmem; Debug Build) [SuccessX]
Hint: /home/tr3nx/coding/nim/hvm/vm  [Exec]
---------------------
 ip = 24 | fp = 0
    Code | Push (9)
   Stack | @[2]
  Memory | []

---------------------
 ip = 0 | fp = 3
    Code | Call (17)
   Stack | @[2, 1, 0, 27]
  Memory | []

---------------------
 ip = 2 | fp = 3
    Code | Arg (18)
   Stack | @[2, 1, 0, 27, 2]
  Memory | []

---------------------
 ip = 4 | fp = 3
    Code | Push (9)
   Stack | @[2, 1, 0, 27, 2, 2]
  Memory | []

---------------------
 ip = 5 | fp = 3
    Code | Lt (7)
   Stack | @[2, 1, 0, 27, 0]
  Memory | []

---------------------
 ip = 10 | fp = 3
    Code | JumpFalse (16)
   Stack | @[2, 1, 0, 27]
  Memory | []

---------------------
 ip = 12 | fp = 3
    Code | Arg (18)
   Stack | @[2, 1, 0, 27, 2]
  Memory | []

---------------------
 ip = 14 | fp = 3
    Code | Arg (18)
   Stack | @[2, 1, 0, 27, 2, 2]
  Memory | []

---------------------
 ip = 16 | fp = 3
    Code | Push (9)
   Stack | @[2, 1, 0, 27, 2, 2, 1]
  Memory | []

---------------------
 ip = 17 | fp = 3
    Code | Sub (2)
   Stack | @[2, 1, 0, 27, 2, 1]
  Memory | []

---------------------
 ip = 0 | fp = 8
    Code | Call (17)
   Stack | @[2, 1, 0, 27, 2, 1, 1, 3, 20]
  Memory | []

---------------------
 ip = 2 | fp = 8
    Code | Arg (18)
   Stack | @[2, 1, 0, 27, 2, 1, 1, 3, 20, 1]
  Memory | []

---------------------
 ip = 4 | fp = 8
    Code | Push (9)
   Stack | @[2, 1, 0, 27, 2, 1, 1, 3, 20, 1, 2]
  Memory | []

---------------------
 ip = 5 | fp = 8
    Code | Lt (7)
   Stack | @[2, 1, 0, 27, 2, 1, 1, 3, 20, 1]
  Memory | []

---------------------
 ip = 7 | fp = 8
    Code | JumpFalse (16)
   Stack | @[2, 1, 0, 27, 2, 1, 1, 3, 20]
  Memory | []

---------------------
 ip = 9 | fp = 8
    Code | Push (9)
   Stack | @[2, 1, 0, 27, 2, 1, 1, 3, 20, 1]
  Memory | []

---------------------
 ip = 20 | fp = 3
    Code | Ret (19)
   Stack | @[2, 1, 0, 27, 2, 1]
  Memory | []

---------------------
 ip = 21 | fp = 3
    Code | Mul (3)
   Stack | @[2, 1, 0, 27, 2]
  Memory | []

---------------------
 ip = 27 | fp = 0
    Code | Ret (19)
   Stack | @[2]
  Memory | []

2
```
