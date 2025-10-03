'''Step counter function
def feet_to_steps(user_feet):
    return int(user_feet / 2.5)

if __name__ == '__main__':
    user_input = float(input("How many feet did you walk? "))
    steps = feet_to_steps(user_input)
    print(f"You did {steps} steps")
'''

'''What's my grade?
grade = float(input("What is your numerical grade? "))
if 95 <= grade <= 100:
    print("You got an A.")
elif 90 <= grade < 95:
    print("You got an A-.")
elif 86.66 <= grade < 90:
    print("You got a B+.")
elif 83.33 <= grade < 86.66:
    print("You got a B.")
elif 80 <= grade < 83.33:
    print("You got a B-.")
elif 76.66 <= grade < 80:
    print("You got a C+.")
else:
    print("You got less than C+.")
'''

'''Palindrome List 1
int_list = user_input = input("Enter a list of integers separated by a space: ").split()
is_palindrome = True
for i in range(len(int_list) // 2):
    if int_list[i] != int_list[-(i + 1)]:
        is_palindrome = False
        break
if is_palindrome:
    print("Yes, it is palindrome")
else:
    print("No, it is NOT palindrome")
'''

'''Draw an asterisks (*) triangle
height=int(input('Please enter the desired height: '))
print('')
for i in range(1, height + 1):
    for j in range(i):
        print('*', end=' ')
    print('')
'''