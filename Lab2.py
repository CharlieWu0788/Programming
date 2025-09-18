from math import ceil
n_cupcakes = int(input('How many people do you need to serve? '))
cupcakes_per_batch = 12
n_batches = ceil(n_cupcakes / cupcakes_per_batch)
n_flour_cups = (n_batches * 1.5)
n_flour_bags = ceil(n_flour_cups / 20)
cost_flour_bag = 3.09
n_granulated_sugar_cups = (n_batches * 1.0)
n_granulated_sugar_bags = ceil(n_granulated_sugar_cups / 10)
cost_granulated_sugar_bag = 2.98
n_unsalted_butter_cups = (n_batches * (0.5 + 1))
n_unsalted_butter_boxes = ceil(n_unsalted_butter_cups / 2)
cost_unsalted_butter_box = 2.50
n_sour_cream_cup = (n_batches * 0.5)
n_sour_cream_tubs = ceil(n_sour_cream_cup / 1)
cost_sour_cream_tub = 1.29
n_eggs_single = (n_batches * 3)
n_eggs_dozen = ceil(n_eggs_single / 12)
cost_eggs_dozen = 2.68
n_powdered_sugar_cups = (n_batches * 2.5)
n_powdered_sugar_bags = ceil(n_powdered_sugar_cups / 5.5)
cost_powdered_sugar_bag = 1.18
n_vanilla_extract_teaspoon = (n_batches * (1.5 + 3))
n_vanilla_extract_bottles = ceil(n_vanilla_extract_teaspoon / 12)
cost_vanilla_extract_bottle = 4.12
total_cost = (n_flour_bags * cost_flour_bag 
              + n_granulated_sugar_bags * cost_granulated_sugar_bag 
              + n_unsalted_butter_boxes * cost_unsalted_butter_box 
              + n_sour_cream_tubs * cost_sour_cream_tub 
              + n_eggs_dozen * cost_eggs_dozen 
              + n_powdered_sugar_bags * cost_powdered_sugar_bag 
              + n_vanilla_extract_bottles * cost_vanilla_extract_bottle)
print('You need to make:', n_batches ,'batch(es) of cupcakes')
print('Shopping List for Vanilla Cupcakes')
print('----------------------------------')
print(n_flour_bags ,'bag(s) of flour')
print(n_granulated_sugar_bags ,'bag(s) of granulated sugar')
print(n_unsalted_butter_boxes ,'box(es) of butter')
print(n_sour_cream_tubs ,'tub(s) of sour cream')
print(n_eggs_dozen ,'dozen(s) of eggs')
print(n_powdered_sugar_bags ,'bag(s) of powdered sugar')
print(n_vanilla_extract_bottles ,'bottle(s) of vanilla extract')
print('Total expected cost of ingredients: $', total_cost)
print('Have a great party!')