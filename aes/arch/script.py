for i in range(0, 32):
    index = str((i * 128) + 127) + ":" + str((i*128))
    print("\ttest_enc enc" + str(i) + "(clk, inBus[" + index + "], outBus[" + index + "]);");