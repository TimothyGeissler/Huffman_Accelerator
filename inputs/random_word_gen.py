import random
import string

# Generates list of random words
word_list = ["apple", "banana", "cherry", "date", "elderberry", "fig", "grape", "honeydew", "kiwi", "lemon"]

def generate_random_string(n, word_list):
    random_string = []
    
    while len(" ".join(random_string)) < n:
        random_word = random.choice(word_list)
        random_string.append(random_word)

    return " ".join(random_string)

# Example usage:
string_length = 100000  # Change this to the desired length of the random string
random_string = generate_random_string(string_length, word_list)
print(random_string)
