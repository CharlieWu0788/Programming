import csv
filename = 'LA_September_Temperature.csv'
with open(filename, 'r') as read_obj:
    csv_reader = csv.reader(read_obj)
    list_of_LASepTemp = list(csv_reader)
header = list_of_LASepTemp[0]
for x in range(1, len(list_of_LASepTemp)):
    for y in range(1, len(list_of_LASepTemp[0])):
        list_of_LASepTemp[x][y] = round((float(list_of_LASepTemp[x][y]) - 32) * 5 / 9, 2)
filename = 'LA_September_Temperature_Celcius.csv'
with open(filename, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile) 
    csv_writer.writerow(header)
    csv_writer.writerows(list_of_LASepTemp[1:])
print(f'Data written to {filename}')

with open(filename, 'r') as csvfile:
    csv_reader = csv.reader(csvfile)
    list_of_LASepTemp = list(csv_reader)

Day_in_Week_For_Avg_Temp = input('Enter the day of the week (e.g., Monday) that you want the average temperature in the month for: ')
day_index = {'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6, 'Sunday': 7}
if Day_in_Week_For_Avg_Temp in day_index:
    index = day_index[Day_in_Week_For_Avg_Temp]
    total_temp = 0
    day_count = 0
    for i in range(1, len(list_of_LASepTemp)):
        if (i - 1) % 7 + 1 == index:
            total_temp += float(list_of_LASepTemp[i][1])
            day_count += 1
    if day_count > 0:
        avg_temp = total_temp / day_count
        print(f'The average temperature for {Day_in_Week_For_Avg_Temp} in September is: {round(avg_temp, 2)}°C')
    else:
        print('No data available for the selected day.')

Time_of_Day_For_Avg_Temp = input('Enter the time of day (e.g., 00:00) that you want the average temperature in the month for: ')
time_index = {'00:00':0, '01:00':1, '02:00':2, '03:00':3, '04:00':4, '05:00':5, '06:00':6, '07:00':7, '08:00':8, '09:00':9, '10:00':10, '11:00':11, '12:00':12, '13:00':13, '14:00':14, '15:00':15, '16:00':16, '17:00':17, '18:00':18, '19:00':19, '20:00':20, '21:00':21, '22:00':22, '23:00':23}
if Time_of_Day_For_Avg_Temp in time_index:
    index = time_index[Time_of_Day_For_Avg_Temp] + 1
    total_temp = 0
    day_count = 0
    for i in range(1, len(list_of_LASepTemp)):
        print(f"Row {i}: {list_of_LASepTemp[i]} (len={len(list_of_LASepTemp[i])})")  # 调试用
        if len(list_of_LASepTemp[i]) > index:
            total_temp += float(list_of_LASepTemp[i][index])
            day_count += 1
    if day_count > 0:
        avg_temp = total_temp / day_count
        print(f'The average temperature for {Time_of_Day_For_Avg_Temp} in September is: {round(avg_temp, 2)}°C')
    else:
        print('No data available for the selected time.')

min_temp = float('inf')
max_temp = float('-inf')
for i in range(1, len(list_of_LASepTemp)):
    for j in range(1, len(list_of_LASepTemp[0])):
        temp = float(list_of_LASepTemp[i][j])
        if temp < min_temp:
            min_temp = temp
        if temp > max_temp:
            max_temp = temp
if min_temp != float('inf') and max_temp != float('-inf'):
    print(f'The minimum temperature in September is: {round(min_temp, 2)}°C')
    print(f'The maximum temperature in September is: {round(max_temp, 2)}°C')
else:
    print('No valid temperature data available.')
