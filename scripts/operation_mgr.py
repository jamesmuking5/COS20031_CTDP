import mysql.connector
import random
from datetime import datetime, timedelta

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

# Get all property ids
cursor.execute("SELECT property_id FROM property")
properties = cursor.fetchall()

# Get all property ids and their associated user ids
cursor.execute("SELECT property.property_id, property_owner.user_id FROM property JOIN property_owner ON property.user_id = property_owner.user_id")
properties_and_owners = cursor.fetchall()

# Get all staff ids
cursor.execute("SELECT staff_id FROM internal_staff")
staffs = cursor.fetchall()

# Define floorplan url
floorplans = ["https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.reddit.com%2Fr%2Ffloorplan%2Fcomments%2F18w5okr%2Fliving_area_inside_pole_barn_floor_plan%2F&psig=AOvVaw0UwsGzrrTfH5XXsmaxJSnX&ust=1714724462029000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMDLjcvE7oUDFQAAAAAdAAAAABAZ"]

#generate case description scenarios
case_choices= ["Plumbing issue", "Wall defect", "Internet issue", "Electrical issue", "Flooring issue", "Roofing issue", "HVAC issue", "Window issue", "Door issue", "Appliance issue", "Pest issue", "Security issue", "Other issue"]

#generate staff comments scenarios
staff_comments = ["Urgent fix", "Needs immediate attention", "Can be scheduled", "Not a priority", "Requires further investigation", "Resolved", "No action required", "Needs follow-up", "Requires additional resources", "Needs approval", "Needs vendor support", "Needs parts replacement", "Needs software update", "Needs hardware upgrade", "Needs network configuration", "Needs system reboot", "Needs system update", "Needs system reinstallation", "Needs system replacement", "Needs system repair", "Needs system maintenance", "Needs system calibration", "Needs system testing", "Needs system inspection", "Needs system verification", "Needs system validation", "Needs system monitoring"]

# Get all property ids and their associated user ids
cursor.execute("SELECT property.property_id, property_owner.user_id FROM property JOIN property_owner ON property.user_id = property_owner.user_id")
properties_and_owners = cursor.fetchall()

# Generate 50 cases
for _ in range(50):
    # Randomly select a property and its owner, and a staff
    property_id, user_id = random.choice(properties_and_owners)
    staff_id = random.choice(staffs)[0]
    floorplan_defect = random.choice(floorplans)
    case_Desc = random.choice(case_choices)

    # Generate a random date in the past year for date_opened
    start_date = datetime.now() - timedelta(days=365)
    random_days = random.randint(0, 365)
    date_opened = start_date + timedelta(days=random_days)

    # Generate a random date after date_opened for date_closed
    random_days = random.randint(0, 365)
    date_closed = date_opened + timedelta(days=random_days)

    staff_comment = random.choice(staff_comments)  # Replace this with actual logic for generating staff comments

    # Insert a new case
    cursor.execute(
        "INSERT INTO cases (user_id, property_id, staff_id, floorplan_defect, case_Desc, date_opened, date_closed, staff_comment) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
        (user_id, property_id, staff_id, floorplan_defect, case_Desc, date_opened, date_closed, staff_comment)
    )

# Commit the changes and close the connection
conn.commit()
conn.close()