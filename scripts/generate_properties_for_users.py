import mysql.connector
import random

# Define connection
config = {
    'user': 'root',
    'host': '127.0.0.1',
    'database': 'beef_noodles_3',
    'raise_on_warnings': True
}

# Create connection
conn = mysql.connector.connect(**config)

# Create a cursor from the connection
cursor = conn.cursor()

# Get all property owners
cursor.execute("SELECT user_id FROM property_owner")
owners = cursor.fetchall()

# Get all property types
cursor.execute("SELECT pType_id FROM property_type")
types = cursor.fetchall()

# Define possible values for ownership_status, development_status, and city
ownership_statuses = [0, 1]
development_statuses = [0, 1]
cities = ['Kuching', 'Miri', 'Bintulu']
floorplans = ["https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.reddit.com%2Fr%2Ffloorplan%2Fcomments%2F18w5okr%2Fliving_area_inside_pole_barn_floor_plan%2F&psig=AOvVaw0UwsGzrrTfH5XXsmaxJSnX&ust=1714724462029000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMDLjcvE7oUDFQAAAAAdAAAAABAZ"]

# For each owner, generate 1-6 properties
for owner in owners:
    num_properties = random.randint(1, 6)
    for _ in range(num_properties):
        # Randomly select a property type, ownership status, development status, and city
        property_type = random.choice(types)[0]
        ownership_status = random.choice(ownership_statuses)
        development_status = random.choice(development_statuses)
        city = random.choice(cities)
        floorplan = random.choice(floorplans)

        # Insert a new property for the current owner
        cursor.execute(
            "INSERT INTO property (user_id, pType_id, ownership_status, development_status, city, floorplan) VALUES (%s, %s, %s, %s, %s, %s)",
            (owner[0], property_type, ownership_status, development_status, city, floorplan)
        )

# Commit the changes and close the connection
conn.commit()
conn.close()