#bio
# pentominoes
---
>[!summary] An interesting 2023 BIO Q2


# Explanation
---
This is a pretty typical [[matrix|grid]] [[ad hoc|implementation]] question. However, there are a couple points to note:
- when checking for identical pentomino layouts, make sure to create a "bounding box" around each result to make sure that two objects with the same shape but different positions are treated as identical.
- when creating the grid, make sure to deepcopy when duplicating (in python)

# Code
---
```python
import copy

blocks = {
        "F": [(0,-1), (1,0), (0,0), (-1,0), (-1,1)],
        "G": [(0,1), (1,0), (0,0), (-1,0), (-1,-1)],
        "I": [(-1,0),(0,0),(1,0),(2,0),(3,0)],
        "L": [(-1,0),(0,0),(1,0),(2,0),(2,1)],
        "J": [(-1,0),(0,0),(1,0),(2,0),(2,-1)],
        "N": [(0,0),(1,0),(2,0),(0,1),(-1,1)],
        "M": [(0,0),(1,0),(2,0),(0,-1),(-1,-1)],
        "P": [(0,0),(1,0),(0,1),(-1,0),(-1,1)],
        "Q": [(0,0),(1,0),(0,-1),(-1,-1),(-1,0)],
        "T": [(0,0),(1,0),(-1,0),(-1,-1),(-1,1)],
        "U": [(0,0),(0,1),(0,-1),(-1,-1),(-1,1)],
        "V": [(0,0),(-1,0),(1,0),(1,1),(1,2)],
        "W": [(0,0),(0,-1),(1,0),(1,1),(-1,-1)],
        "X": [(0,0),(0,1),(0,-1),(1,0),(-1,0)],
        "Z": [(0,0),(1,0),(-1,0),(-1,-1),(1,1)],
        "S": [(0,0),(1,0),(-1,0),(-1,1),(1,-1)],
        "Y": [(0,0),(0,-1),(-1,0),(1,0),(2,0)],
        "A": [(0,0),(0,1),(-1,0),(1,0),(2,0)]
        }


grid = [[0 for d in range(20)] for e in range(20)]

blockA,blockB = (blocks[d] for d in input())

for i in blockA:
    grid[10+i[0]][10+i[1]] = 1


def ok(x,y):
    return x < 20 and y < 20 and x >= 0 and y >= 0


used = {}
for i in range(20):
    for j in range(20):
        skip = False
        x = copy.deepcopy(grid)
        touching = False
        used2 = []
        maxrow = -1
        maxcol = -1
        minrow = 192384
        mincol = 320894790

        for k in blockB:
            pos = (i+k[0], j+k[1])
            if not ok(*pos) or x[pos[0]][pos[1]] == 1:
                skip = True
                break

            for l in [(0,1),(0,-1),(1,0),(-1,0)]:
                if not ok(pos[0] +l[0], pos[1] +l[1]):
                    continue
                if (pos[0] +l[0], pos[1] +l[1]) in used2:
                    continue
                if x[pos[0] +l[0]][pos[1] +l[1]] == 1:
                    touching = True
                    break

            x[pos[0]][pos[1]] = 1
            used2.append(pos)

        if skip: continue
        if not touching: continue

        for i1 in range(20):
            for j1 in range(20):
                if x[i1][j1] == 1:
                    minrow = min(i1,minrow)
                    mincol = min(j1,mincol)
                    maxrow = max(i1,maxrow)
                    maxcol = max(j1,maxcol)

        y = ""

        for one in range(minrow, maxrow+1):
            for two in range(mincol, maxcol+1):
                y += str(x[one][two])

        used[y] = True;

print(len(used.keys()))


```