'''Algorithm to calculate the factorial of a number
n = int(input("Enter a number to calculate its factorial: "))
def factorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return n * factorial(n - 1)
print(f"The factorial of {n} is {factorial(n)}")
'''

n = int(input("Please enter a number between 1 and 100: "))
while n < 1 or n > 100:
    n = int(input("Invalid input. Please enter a number between 1 and 100: "))
print(f"Thanks for typing a correct number, You entered: {n}")