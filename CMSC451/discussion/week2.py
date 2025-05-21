#discussion post detailing a recursive function in which the amount of work on each activation is constant.

def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

print(factorial(5))