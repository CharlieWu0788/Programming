
#Age Comparison - Icebreaker Common Points
print("Let's compare our ages!")
my_age = input('Enter my age: ')
your_age = input('Enter your age: ')
age_diff = int(your_age) - int(my_age)
commonpoints = 0
if(age_diff == 0):
    print('We are of the same age.')
    commonpoints += 1
elif(age_diff > 0):
    print('You are older than me by', age_diff, 'years.')
else: # age_diff < 0
    print('I am older than you by', -age_diff, 'years.')
print('We have', commonpoints, 'common points.')