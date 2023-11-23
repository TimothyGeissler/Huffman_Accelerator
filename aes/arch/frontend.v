`include "test_enc.v"

module frontend(
    input clk,
    input [4095:0] inBus, //32 parallel encryptors
    output [4095:0] outBus
);

    test_enc enc0(clk, inBus[127:0], outBus[127:0]);
    test_enc enc1(clk, inBus[255:128], outBus[255:128]);
    test_enc enc2(clk, inBus[383:256], outBus[383:256]);
    test_enc enc3(clk, inBus[511:384], outBus[511:384]);
    test_enc enc4(clk, inBus[639:512], outBus[639:512]);
    test_enc enc5(clk, inBus[767:640], outBus[767:640]);
    test_enc enc6(clk, inBus[895:768], outBus[895:768]);
    test_enc enc7(clk, inBus[1023:896], outBus[1023:896]);
    test_enc enc8(clk, inBus[1151:1024], outBus[1151:1024]);
    test_enc enc9(clk, inBus[1279:1152], outBus[1279:1152]);
    test_enc enc10(clk, inBus[1407:1280], outBus[1407:1280]);
    test_enc enc11(clk, inBus[1535:1408], outBus[1535:1408]);
    test_enc enc12(clk, inBus[1663:1536], outBus[1663:1536]);
    test_enc enc13(clk, inBus[1791:1664], outBus[1791:1664]);
    test_enc enc14(clk, inBus[1919:1792], outBus[1919:1792]);
    test_enc enc15(clk, inBus[2047:1920], outBus[2047:1920]);
    test_enc enc16(clk, inBus[2175:2048], outBus[2175:2048]);
    test_enc enc17(clk, inBus[2303:2176], outBus[2303:2176]);
    test_enc enc18(clk, inBus[2431:2304], outBus[2431:2304]);
    test_enc enc19(clk, inBus[2559:2432], outBus[2559:2432]);
    test_enc enc20(clk, inBus[2687:2560], outBus[2687:2560]);
    test_enc enc21(clk, inBus[2815:2688], outBus[2815:2688]);
    test_enc enc22(clk, inBus[2943:2816], outBus[2943:2816]);
    test_enc enc23(clk, inBus[3071:2944], outBus[3071:2944]);
    test_enc enc24(clk, inBus[3199:3072], outBus[3199:3072]);
    test_enc enc25(clk, inBus[3327:3200], outBus[3327:3200]);
    test_enc enc26(clk, inBus[3455:3328], outBus[3455:3328]);
    test_enc enc27(clk, inBus[3583:3456], outBus[3583:3456]);
    test_enc enc28(clk, inBus[3711:3584], outBus[3711:3584]);
    test_enc enc29(clk, inBus[3839:3712], outBus[3839:3712]);
    test_enc enc30(clk, inBus[3967:3840], outBus[3967:3840]);
    test_enc enc31(clk, inBus[4095:3968], outBus[4095:3968]);



endmodule