
noise_mask = 0
encoded_message = 0

non_noised_messages_strings = ["00000000",
                               "10000111",
                               "10011001",
                               "00011110",
                               "10101010",
                               "00101101",
                               "00110011",
                               "10110100",
                               "01001011",
                               "11001100",
                               "11010010",
                               "01010101",
                               "11100001",
                               "01100110",
                               "01111000",
                               "11111111" ]


non_noised_messages = [int(e, 2) for e in non_noised_messages_strings]
decoded_messages =[i for i in range(15)]

for i, message in enumerate(non_noised_messages):
    encoded_message = message
    print(f"""\tencoded <= \"{(bin(encoded_message))[2:]:0>8}\";
\twait for period;
\treport( \"Encoded message is \" & to_string(encoded));
\tassert ((corrected = '0') and (error = '0') and (decoded = \"{bin(i)[2:]:0>4}\"))
\t\treport(\"Test failed for \" & \"{(bin(encoded_message))[2:]:0<8}\" & \" | Corrected or Error are wrong: \" & to_string(corrected) & to_string(error)); 
""")




