#'''Exact change
c = cents = int(input('How many cents you need to give as change? '))
if cents <= 0:
    print('No change')
else:
    coins = [
        (100, "Dollar", "Dollars"),
        (25, "Quarter", "Quarters"),
        (10, "Dime", "Dimes"),
        (5, "Nickel", "Nickels"),
        (1, "Penny", "Pennies")
    ]
    print('You need to give:')
    for value, singular, plural in coins:
        count = cents // value
        cents %= value
        if count > 0:
            name = singular if count == 1 else plural
            print(f"{count} {name}")
#'''
 
#'''Golf score
par = int(input("What's the par for this hole? "))
print(' ')
strokes = int(input('How many strokes did you do? '))
print(' ')
if par not in [3, 4, 5] or strokes < 1:
    print("Sorry, it seems you entered an invalid number")
else:
    diff = strokes - par
    if diff == -2:
        score = "Eagle"
    elif diff == -1:
        score = "Birdie"
    elif diff == 0:
        score = "Par"
    elif diff == 1:
        score = "Bogey"
    elif diff == 2:
        score = "Double Bogey"
    elif diff == 3:
        score = "Triple Bogey"
    elif diff > 3:
        score = f"+{diff}"
    else:
        score = f"{strokes} strokes under par"
    print(f'Par {par} in {strokes} strokes is {score}')
#'''

