def generate_bad_p(name: str, num_pets: int, graduation_year: str) -> str:
    num_pets = str(num_pets)
    pwd = name+num_pets+graduation_year
    return pwd
my_pwd = generate_bad_p('Charlie', 2, '2029')
print(my_pwd)


