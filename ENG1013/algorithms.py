from math import floor


def merge(left, right):
    result = []
    
    while len(left) != 0 and len(right) != 0:
        if left[0] <= right[0]:
            result.append(left.pop(0))
        else:
            result.append(right.pop(0))
    
    while len(left) != 0:
        result.append(left.pop(0))
    
    while len(right) != 0:
        result.append(right.pop(0))
    
    return result

def mergeSort(n):
    if len(n) == 1:
        return n
    
    left = n[:len(n)//2]
    right = n[len(n)//2:]
    
    left = mergeSort(left)
    right = mergeSort(right)
    
    return merge(left, right)
    

list1 = [7, 5, 9, 3, 11, 3, 4, 1]
sorted = mergeSort(list1)
print(sorted)

# List , Length of list, number ot be searched
def Bsearch(A, n, T):
    L = 0
    R = n - 1
    while L <= R:
        m = floor((L + R) / 2)
        if A[m] < T:
            L = m + 1
        elif A[m] > T:
            R = m - 1
        else:
            return m
    return -1

def binary_search(ls, n):
    return Bsearch(ls, len(sorted), n)

print(binary_search(sorted, 9))