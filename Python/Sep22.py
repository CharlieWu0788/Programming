'''Nested loops
import csv
array_2D = [[10,51,12],[19,36,72],[6,88,67]]
result = [array_2D[x][y] for x in range(len(array_2D)) for y in range(len(array_2D[0]))]
for element in result:
    print(element)
filename = 'array_2D.csv'
with open(filename, 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerows(array_2D)
print(f'Data written to {filename}')
'''
import csv
with open('LA_September_Temperature.csv', 'r') as read_obj:
    csv_reader = csv.reader(read_obj)
    list_of_LASepTemp = list(csv_reader)
for x in range(1, len(list_of_LASepTemp)):
    for y in range(1, len(list_of_LASepTemp[0])):
        list_of_LASepTemp[x][y] = round((float(list_of_LASepTemp[x][y]) - 32) * 5 / 9, 2)
filename = 'LA_September_Temperature_Celcius.csv'
with open(filename, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerows(list_of_LASepTemp)
print(f'Data written to {filename}')

    