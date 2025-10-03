'''A jiffy'''
def jiffies_to_seconds(user_jiffies):
    return user_jiffies / 100

if __name__ == '__main__':
    user_input = float(input('How many jiffies elapsed? '))
    seconds = jiffies_to_seconds(user_input)
    print(f'{seconds} seconds elapsed')

'''Movie ticket prices'''
time_of_day=input('Is it Day or Night? ')
age=int(input("What's your age? "))

if age < 4:
    price = 0
elif time_of_day == "Day":
    price = 8
elif time_of_day == "Night":
    if age <= 16:
        price = 12
    elif age <= 54:
        price = 15
    else:
        price = 13
if price == 0:
    print('Your movie ticket is free')
else:
    print(f'The price for your movie ticket is ${price}')

'''Product of sums'''
def str_to_int_list(str_list):
    int_list=[]
    for element in str_list:
        int_list.append(int(element))
    return int_list

list1=str_to_int_list(input('Enter the first list of numbers separated by a space: ').split())
list2=str_to_int_list(input('Enter the second list of numbers separated by a space: ').split())
print(' ')

product = 1
for i in range(len(list1)):
    product *= (list1[i] + list2[i])
print(product)

'''Draw an asterisks (*) triangle'''
height=int(input('Please enter the desired height: '))
print('')
for i in range(height):
    for j in range(height - i - 1):
        print(' ', end=' ')
    for k in range(i + 1):
        print('*', end=' ')
    print('')
