'''Input Value Comparison
v1 = variable1 = input('Enter first variable: ')
v2 = variable2 = input('Enter second variable: ')
v3 = variable3 = input('Enter third variable: ')

if (v1 == v2):
    if (v1 == v3):
        print('Variable 1, Variable 2 and Variable 3 are all equal.')
    else:
        print('Variable 1 and Variable 2 are equal, but Variable 3 is different.')
elif v1 == v3:
    print('Variable 1 and Variable 3 are equal, but Variable 2 is different.')
elif v2 == v3:
    print('Variable 2 and Variable 3 are equal, but Variable 1 is different.')
else:
    print('All variables are different.')
'''

'''Smallest Number
v1 = float(input('Please enter a number: '))
v2 = float(input('Please enter another number: '))
v3 = float(input('Please enter another number: '))
if (v1 <= v2) and (v1 <= v3):
    print('The smallest number is', v1)
elif (v2 <= v1) and (v2 <= v3):
    print('The smallest number is', v2)
elif (v3 <= v1) and (v3 <= v2):
    print('The smallest number is', v3)
else:
    print('There is no smallest number.')
'''

'''Moving in a given direction'''
d = direction = str(input('Please provide a direction to move (up, down, left, right): '))
print('')
if d == 'up' or d == 'Up' or d == 'UP':
    print(f'You moved {d}.')
elif d == 'down' or d == 'Down' or d == 'DOWN':
    print(f'You moved {d}.')
elif d == 'left' or d == 'Left' or d == 'LEFT':
    print(f'You moved {d}.')
elif d == 'right' or d == 'Right' or d == 'RIGHT':
    print(f'You moved {d}.')
else:
    print('Sorry, direction not recognized.')