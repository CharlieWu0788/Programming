def input_user_list() -> list:
    '''
    n_elements = int(input('How many elements will the list have? '))
    print(n_elements)
    user_list = []
    i = 0
    for i in range(1, n_elements + 1):
        user_list.append(input(f'Please enter element {i}: '))
    return user_list
    '''
    '''
    n_elements = int(input('How many elements will the list have? '))
    print(n_elements)
    user_list = [input(f'Please enter element {i}: ') for i in range(1, n_elements + 1)]
    return user_list
    '''
    n_elements = int(input('How many elements will the list have? '))
    print(n_elements)
    return [input(f'Please enter element {i}: ') for i in range(1, n_elements + 1)]
print('The list you created is:', input_user_list())