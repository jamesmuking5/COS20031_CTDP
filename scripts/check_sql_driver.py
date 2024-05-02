import pyodbc

# Get the list of available drivers
drivers = [driver for driver in pyodbc.drivers()]

# Print the drivers
for driver in drivers:
    print(driver)