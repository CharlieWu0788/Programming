'''
shopping_list = {'Meatloaf':['Ground Beef', 'Breadcrumbs'], 'Cake': ['Flour', 'Sugar']}
for keys in shopping_list.keys():
    print(keys)
for values in shopping_list.values():
    print(type(values))
    print(values)
'''
comp131_grades = {'AM_class':{'Hector':'A', 'Joel':'A'}, 'PM_class':{'Charlie':'A', 'David':'A'}}
for keys in comp131_grades.keys():
    print(keys)
for values in comp131_grades.values():
    print(type(values))
    print(values)
charlie_grade = comp131_grades['PM_class']['Charlie'] = 'A*'
pm_grades = list(comp131_grades['PM_class'].values())