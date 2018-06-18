#! /usr/bin/env python
import requests
from string import ascii_uppercase

ROOMS = ["MLD401", "MLD328", "MLD301", "MLD428"]
URL = 'http://housing.gatech.edu/rooms/FreeRooms.json?_=1520399603861'

def check_room(data, rooms):
    available = []
    for room in rooms:
        for slot in data:
            if room in slot['RoomNumber'] and "Dynamic" in slot['Gender']:
                available.append(room)
                break
    return available


r = requests.get(URL)
available = check_room(r.json(), ROOMS)
print(', '.join(available))