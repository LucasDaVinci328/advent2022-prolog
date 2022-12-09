def points(l, r):
    if (l=='A'):
        if (r=='X'):
            return 3
        elif (r=='Y'):
            return 4
        elif (r=='Z'):
            return 8
    elif (l=='B'):
        if (r=='X'):
            return 1
        elif (r=='Y'):
            return 5
        elif (r=='Z'):
            return 9
    elif(l=='C'):
        if (r=='X'):
            return 2
        elif (r=='Y'):
            return 6
        elif (r=='Z'):
            return 7


s = 0

with open("strat.txt", 'r') as file:
    for line in file:
        s+=points(line[0], line[2])
        print(points(line[0], line[2]))
print(s)
