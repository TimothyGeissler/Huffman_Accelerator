def read_text_file():
    try:
        with open("inputs/random_100k_input.txt", 'r') as file:
            # Read the content of the file and store it in a variable
            file_contents = file.read()
            return file_contents
    except FileNotFoundError:
        print(f"File not found: inputs/random_100k_input.txt")
        return None
	

def character_frequency(string):
    # Initialize an empty dictionary to store character frequencies
    char_count = {}

    # Iterate through each character in the string
    for char in string:
        # Use the get method to update the character count in the dictionary
        char_count[char] = char_count.get(char, 0) + 1

    return char_count


inString = read_text_file()

frequency = character_frequency(inString)
print(frequency)