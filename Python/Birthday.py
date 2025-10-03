Y = int(input("Enter the year of your birthday in YYYY format:"))
M = int(input("Enter the month of your birthday in MM format:"))
D = int(input("Enter the day of your birthday in DD format:"))

def is_leap_year(year: int) -> bool:
    if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0): #a leap year
        return True
    else:
        return False

def is_valid_date(year: int, month: int, day: int) -> bool:
    if (is_leap_year(Y) == True) and (month == 2) and (day > 29 or day < 1):
        return False
    elif is_leap_year(Y) == False and month == 2 and (day > 28 or day < 1):
        return False
    elif (month == 1 or month == 3 or  month == 5 or month == 7 or month == 8 or month == 10) and (day > 31 or day < 1):
        return False
    elif (month == 4 or month == 6 or  month == 9 or month == 11) and (day > 30 or day < 1):
        return False
    elif month > 12:
        return False
    
def Zellercongruence(day, month, year):
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    if (month < 3):
        month += 12
        year -= 1
    c = year // 100
    year = year % 100
    h = (c // 4 - 2 * c + year + year // 4 + 13 * (month + 1) // 5 + day - 1) % 7
    return days[(h + 7) % 7]
    
if is_valid_date(Y, M, D) == False:
    print("Sorry, invalid date")
else:
    print(f"You were born on a {Zellercongruence(D, M, Y)}!")