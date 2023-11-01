# A Huffman Tree Node 
import heapq 


class node: 
	def __init__(self, freq, symbol, left=None, right=None): 
		# frequency of symbol 
		self.freq = freq 

		# symbol name (character) 
		self.symbol = symbol 

		# node left of current node 
		self.left = left 

		# node right of current node 
		self.right = right 

		# tree direction (0/1) 
		self.huff = '' 

	def __lt__(self, nxt): 
		return self.freq < nxt.freq 


# utility function to print huffman 
# codes for all symbols in the newly 
# created Huffman tree 

def printNodes(node, val=''): 
	map = {}
	# huffman code for current node 
	newVal = val + str(node.huff) 

	# if node is not an edge node 
	# then traverse inside it 
	if(node.left): 
		map.update(printNodes(node.left, newVal))
	if(node.right): 
		map.update(printNodes(node.right, newVal))

		# if node is edge node then 
		# display its huffman code 
	if(not node.left and not node.right): 
		#print(f"{node.symbol} -> {newVal}") 
		map[node.symbol] = newVal

	return map

def read_text_file():
    try:
        with open("input.txt", 'r') as file:
            # Read the content of the file and store it in a variable
            file_contents = file.read()
            return file_contents
    except FileNotFoundError:
        print(f"File not found: input.txt")
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



# characters for huffman tree 
#chars = ['a', 'b', 'c', 'd', 'e', 'f']
# frequency of characters 
#freq = [5, 9, 12, 13, 16, 45] 

# Split into chars array and frequency array
chars = []
freq = []
for c, f in frequency.items():
	chars.append(c)
	freq.append(f)


# list containing unused nodes 
nodes = [] 

# converting characters and frequencies 
# into huffman tree nodes 
for x in range(len(chars)): 
	heapq.heappush(nodes, node(freq[x], chars[x])) 

while len(nodes) > 1: 

	# sort all the nodes in ascending order 
	# based on their frequency 
	left = heapq.heappop(nodes) 
	right = heapq.heappop(nodes) 

	# assign directional value to these nodes 
	left.huff = 0
	right.huff = 1

	# combine the 2 smallest nodes to create 
	# new node as their parent 
	newNode = node(left.freq+right.freq, left.symbol+right.symbol, left, right) 

	heapq.heappush(nodes, newNode) 


def encode(s, map):
	res = ""

	for char in s:
		if char in map:
			res+=map[char]
	
	return res

# Huffman Tree is ready! 
map = printNodes(nodes[0]) 
print("\nMap:\n" + str(map))

encoded = encode(inString, map)
print("\nEncoded=" + encoded)


def decode_string(s, map):
    decoded_string = ""
    current_code = ""

    for bit in s:
        current_code += bit
        # Check if the current code is in the Huffman code map
        for symbol, code in map.items():
            if code == current_code:
                decoded_string += symbol
                current_code = ""
                break

    return decoded_string

decoded = decode_string(encoded, map)
print("Decoded=" + decoded)