class node:
    def __init__(self, queue_pos, symbol, freq):
        self.queue_pos = queue_pos
        self.next_queue_pos = queue_pos
        self.symbol = symbol
        self.is_head = True
        self.freq = freq

if __name__ == "__main__":
    #initialization
    translation_table = {'a': "", 'b': "", 'c': "", 'd': "", 'e': "", 'f': ""}
    arr = [node(0,'a',5), node(1,'b', 9), node(2,'c', 12), node(3,'d', 13), node(4,'e', 16), node(5,'f', 45)]
    reg0 = arr[0].freq
    reg1 = arr[1].freq
    done=False
    while(not done):
        if all(node.queue_pos == 0 for node in arr): #if all elements are the first position in the queue then we are done
            done=True
        else:
            #cycle 1
            print("step1")
            for node in arr:
                print("queue_pos: %d, symbol: %s, freq: %d" % (node.queue_pos, node.symbol, node.freq)) 

            #find combined value of first two elements in queue
            combined_val = reg0+reg1
            
            #update the translation table and the queue array for the first two elements in the queue
            for node in arr:
                if(node.queue_pos == 0):
                    #update translation table
                    translation_table[node.symbol]='0'+translation_table[node.symbol]
                    #update queue array
                    node.freq = combined_val
                if(node.queue_pos == 1):
                    #update translation table
                    translation_table[node.symbol]='1'+translation_table[node.symbol]
                    #update queue array
                    node.next_queue_pos = 0
                    node.is_head = False
                    node.freq = combined_val

            for node in arr: #clock in new values
                node.queue_pos = node.next_queue_pos
                node.next_queue_pos = node.queue_pos

            #cycle 2
            print("step2")
            for node in arr:
                print("queue_pos: %d, symbol: %s, freq: %d" % (node.queue_pos, node.symbol, node.freq)) 

            num_shifted=0
            #update next queue positions based on relative frequencies
            for node in arr:
                if(node.queue_pos != 0 and node.freq-combined_val<0):
                    node.next_queue_pos = node.queue_pos-2
                    if(node.is_head == True):
                        num_shifted+=1
                if(node.queue_pos != 0 and node.freq-combined_val>=0):
                    node.next_queue_pos = node.queue_pos-1
            for node in arr:
                if(node.queue_pos == 0):
                    node.next_queue_pos = num_shifted
            #assugb reg0 and reg1 to the first two elements in the queue
            for node in arr:
                if(node.next_queue_pos == 0):
                    reg0 = node.freq
                if(node.next_queue_pos == 1):
                    reg1 = node.freq
            for node in arr: #clock in new values
                node.queue_pos = node.next_queue_pos
                node.next_queue_pos = node.queue_pos
        #print("---new translation---")
        # for character in translation_table:
        #             print("character: %s translation: %s" % (character, translation_table[character]))
    

        
            
            