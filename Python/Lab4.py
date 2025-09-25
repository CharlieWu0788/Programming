'''Elevating a base to a power
base=int(input("What's the base? "))
power=int(input("What's the power? "))
result=base**power
print(' ')
print(f'{base}to the power of{power}is{result}')
'''
'''Printing a list in different lines
def my_print(list_to_print:list):
    for element in list_to_print:
        print(element)

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(input("What's the value of element at index "+str(index)+"? ")) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    list_to_print=input_list()
    my_print(list_to_print)
'''
'''Function base to a power returning a list
def power_list(base:int,power:int)->list:
    final_list=[]
    index=0
    while index<=power:
        final_list.append(base**index)
        index=index+1
    return final_list
    
if __name__ == '__main__':
    base=int(input("What's the base? "))
    power=int(input("What's the power? "))
    print(' ')
    print(power_list(base,power))
'''
'''Extending a list
def my_extend(list1:list,list2:list)->list:
    for element in list2:
        list1.append(element)
    return list1

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(input("What's the value of element at index "+str(index)+"? ")) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    first_list=input_list()
    second_list=input_list()
    print(my_extend(first_list,second_list))
'''
'''Summing a list
def my_sum(list_integers:list)->int:
    total=0
    for element in list_integers:
        total=total+element
    return total

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    print(my_sum(input_list()))
'''
'''Filtering a list for odd numbers
def my_filter(list_integers:list)->list:
    final_list=[]
    for element in list_integers:
        if element%2!=0:
            final_list.append(element)
    return final_list

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    print(my_filter(input_list()))
'''
'''my_sum
def my_sum(list_integers:list)->int:
    total=0
    for element in list_integers:
        total=total+element
        print('The current sum is: '+str(total))
    return total

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    print(my_sum(input_list()))
'''
'''my_count
def my_count(list_integers:list,x:int)->int:
    count=0
    for element in list_integers:
        if element==x:
            count=count+1
            print('Found')
        else:
            print('Not found')
    return count

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    x=int(input("What's the number to search for? "))
    print(my_count(input_list(),x))
'''
'''my_max
def my_max(list_integers:list)->int:
    max_value=list_integers[0]
    for element in list_integers:
        if element>max_value:
            max_value=element
        print('The current maximum value is: '+str(max_value))
    return max_value

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    print(my_max(input_list()))
'''
'''my_min
def my_min(list_integers:list)->int:
    min_value = list_integers[0]
    for element in list_integers:
        if element < min_value:
            min_value = element
        print('The current minimum value is: ' + str(min_value))
    return min_value
    
def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    print(my_min(input_list()))
'''
'''my_reversed
def my_reversed(list_integers:list)->int:
    reversed_list = []
    index = len(list_integers) - 1
    while index >= 0:
        reversed_list.append(list_integers[index])
        print(reversed_list)
        index -= 1
    return reversed_list

def input_list()->list:
    index=0
    n_elements=int(input('How many elements will the list have? ')) # How many elements the list will have
    final_list=[]
    while index<n_elements:
        final_list.append(int(input("What's the value of element at index "+str(index)+"? "))) # Enter the values for the list
        index=index+1
    print(' ')
    return final_list

if __name__ == '__main__':
    print(my_reversed(input_list()))
'''

