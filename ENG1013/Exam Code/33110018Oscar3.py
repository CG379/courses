# Return true if is a tautonym same word twice in one word (Papa, so-so etc), else false
def is_tautonym(word):
    # make sure valid input
    if word[0].isdigit():
        print("Error: word must not be a number")
        return None
    # Remove all non-letters from the string
    letters = []
    spaceCount = 0
    for i in word:
        if i.isalpha():
            letters.append(i)
        elif i.isspace() or i == "-":
            spaceCount += 1
            continue
        elif i.isnumeric():
            print("Error: word contains numeric characters")
            return None
        if not i.isalpha() and not i.isnumeric():
            print("Error: word contains invalid symbols")
            return None
    if spaceCount > 1:
        return None

    word = ''.join(letters)
    word = word.lower()
    # Check for tautononym
    # Since it is the same word twice, input length is always even
    if len(word) % 2 != 0:
        return False
    firstWord = word[:len(word)//2]
    secondWord = word[len(word)//2:]
    print(firstWord)
    print(secondWord)
    
    if firstWord == secondWord:
        return True
    else:
        return False

