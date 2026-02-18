'''
old_password=input('Enter a password to make stronger: ')
print(' ')
new_password=""

for char in old_password:
    if char == 'i':
        new_password += '1'
    elif char == 'a':
        new_password += '@'
    elif char == 'm':
        new_password += 'M'
    elif char == 'B':
        new_password += '8'
    elif char == 's':
        new_password += '$'
    else:
        new_password += char
new_password += '!'

print('Your new stronger password is:',new_password)
'''
'''When analyzing data sets, such as data for human heights or for human weights, a common step is to adjust the data. This adjustment can be done by normalizing to values between 0 and 1, or throwing away outliers.

For this program, adjust the values by dividing all values by the largest value. You need to create a new list with the normalized values. The normalized values should have two decimal places.

You can round a float to two decimals using the round() function: round(3.141592654,2) gives 3.14. The syntax is round(number_to_round, how_many_decimal_places)

The input begins with an integer indicating the number of floating-point values that follow. Assume that the list will always contain positive floating-point values. You can refer to the programs we did in class to get a certain number of inputs from the user.

Note: since we're getting float values, we need to convert the input to float:

input_value=float(input('Type a new value to normalize: '))

Yes, you can use the predefined function max() to find the maximum'''
''' Don't change these three lines, it helps getting the format right'''
num_values=int(input('How many values are there in the list? '))
list_to_normalize=[]
normalized_list=[]
'''Your code goes here'''
for i in range(num_values):
    input_value=int(input('Type a new value to normalize: '))
    list_to_normalize.append(input_value)
max_value=max(list_to_normalize)
for value in list_to_normalize:
    normalized_value=round(value/max_value,2)
    normalized_list.append(normalized_value)


'''Don't change the prints, it helps get the format right'''
print(' ')
print('The original values are:')
print(list_to_normalize)
print('The normalized values are:')
print(normalized_list)