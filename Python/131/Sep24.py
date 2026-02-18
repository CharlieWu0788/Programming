import csv

def fahrenheit_to_celsius(f):
    return round((float(f) - 32) * 5 / 9, 2)

def convert_csv_to_celsius(input_file, output_file):
    with open(input_file, 'r') as read_obj:
        csv_reader = csv.reader(read_obj)
        data = list(csv_reader)
    header = data[0]
    for x in range(1, len(data)):
        for y in range(1, len(data[0])):
            data[x][y] = fahrenheit_to_celsius(data[x][y])
    with open(output_file, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(header)
        csv_writer.writerows(data[1:])
    print(f'Data written to {output_file}')
    return output_file

def read_csv(file):
    with open(file, 'r') as csvfile:
        csv_reader = csv.reader(csvfile)
        return list(csv_reader)

def avg_temp_by_day(data, day_name):
    day_index = {'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6, 'Sunday': 7}
    if day_name not in day_index:
        print('Invalid day.')
        return
    index = day_index[day_name]
    total_temp = 0
    day_count = 0
    for i in range(1, len(data)):
        if (i - 1) % 7 + 1 == index:
            total_temp += float(data[i][1])
            day_count += 1
    if day_count > 0:
        avg_temp = total_temp / day_count
        print(f'The average temperature for {day_name} in September is: {round(avg_temp, 2)}°C')
    else:
        print('No data available for the selected day.')

def avg_temp_by_time(data, time_str):
    time_index = {'00:00':0, '01:00':1, '02:00':2, '03:00':3, '04:00':4, '05:00':5, '06:00':6, '07:00':7, '08:00':8, '09:00':9, '10:00':10, '11:00':11, 
                  '12:00':12, '13:00':13, '14:00':14, '15:00':15, '16:00':16, '17:00':17, '18:00':18, '19:00':19, '20:00':20, '21:00':21, '22:00':22, '23:00':23}
    if time_str not in time_index:
        print('Invalid time format.')
        return
    index = time_index[time_str] + 1
    total_temp = 0
    day_count = 0
    for i in range(1, 8):
        total_temp += float(data[index][i])
        day_count += 1
    if day_count > 0:
        avg_temp = total_temp / day_count
        print(f'The average temperature for {time_str} in September is: {round(avg_temp, 2)}°C')
    else:
        print('No data available for the selected time.')

def min_max_temp(data):
    min_temp = float('inf')
    max_temp = float('-inf')
    for i in range(1, len(data)):
        for j in range(1, len(data[0])):
            temp = float(data[i][j])
            if temp < min_temp:
                min_temp = temp
            if temp > max_temp:
                max_temp = temp
    if min_temp != float('inf') and max_temp != float('-inf'):
        print(f'The minimum temperature in September is: {round(min_temp, 2)}°C')
        print(f'The maximum temperature in September is: {round(max_temp, 2)}°C')
    else:
        print('No valid temperature data available.')

def main():
    input_file = 'D:\\Wu_sh\\Documents\\Programming\\Python\\LA_September_Temperature.csv'
    output_file = 'D:\\Wu_sh\\Documents\\Programming\\Python\\LA_September_Temperature_Celsius.csv'
    convert_csv_to_celsius(input_file, output_file)
    data = read_csv(output_file)
    
    day_name = input('Enter the day of the week (e.g., Monday) that you want the average temperature in the month for: ')
    avg_temp_by_day(data, day_name)
    
    time_str = input('Enter the time of day (e.g., 00:00) that you want the average temperature in the month for: ')
    avg_temp_by_time(data, time_str)

    min_max_temp(data)

if __name__ == '__main__':
    main()
