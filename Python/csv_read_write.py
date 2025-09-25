import csv

''' How to read a CSV file and get a list '''

filename_read = 'D:\\Wu_sh\\Documents\\Programming\\LA_September_Temperature.csv' #You can include the whole path, or make sure your script and the file are at the same folder

with open(filename_read, 'r') as read_obj:
    csv_reader = csv.reader(read_obj)
    list_from_csv = list(csv_reader) #Change list_from_csv to a more fitting name
    print(list_from_csv) #Verify that it worked. Comment it out afterwards
    

''' Go through each elelemnt of the list with nested loops '''
n_rows = len(list_from_csv)
for row in range(0, n_rows):
    n_col = len(list_from_csv[row])
    for col in range(0, n_col):
        value = list_from_csv[row][col]
        # Do something with the data!
        ''' Your code goes here '''

list_to_save = list_from_csv #This line is for the code to run as it is. It works if you saved the changes in the same list

''' How to write a CSV file from a list '''

# Specify the filename for your CSV
filename_write = 'my_data.csv'

with open(filename_write, 'w', newline='') as csvfile:
    # Create a csv.writer object
    csv_writer = csv.writer(csvfile)
    csv_writer.writerows(list_to_save) #list_to save is the list you want to save as csv file
    print(f"Data successfully saved to {filename_write}") #To verify it was done