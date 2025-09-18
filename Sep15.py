'''This script demonstrates how to unpack a list into individual variables and use them in a formatted string.
my_info = ['Charlie', 'Wu', 'Shanghai, China']
first_name = my_info[0]
last_name = my_info[1]
origin = my_info[2]
print(f'Hello, my name is {first_name} {last_name} and I am from {origin}.')
'''

my_grades = [9,10,7]
your_grades = [7,9,10]
sum_lists = []
for i in range(len(my_grades)):
    print('i', i)
    sum_lists.append(my_grades[i] + your_grades[i])
print('sum_lists', sum_lists)