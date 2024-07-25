import os


for i in range(3):
    print(2)


def fib(n, s, kwarg=1):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fib(n - 1) + fib(n - 2)


print(fib(10))
