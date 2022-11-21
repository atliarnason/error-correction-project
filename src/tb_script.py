import random


def main():
    for i in range(20,40):
        print(write_test(i))


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

def print_non_noised_messages():
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

def print_noised_messages():
    noised_messages = [int(e, 2) ^ (1 << random.randint(0,7))  for e in non_noised_messages_strings]
    decoded_messages =[i for i in range(15)]
    for i, message in enumerate(noised_messages):
        encoded_message = message
        print(f"""\tencoded <= \"{(bin(encoded_message))[2:]:0>8}\";
    \twait for period;
    \treport( \"Encoded message is \" & to_string(encoded));
    \tassert ((corrected = '1') and (error = '0') and (decoded = \"{bin(i)[2:]:0>4}\"))
    \t\treport(\"Test failed for \" & \"{(bin(encoded_message))[2:]:0<8}\" & \"decoded_message_expected = {(bin(i))[2:]:0<8} but was actually \" & to_string(decoded) & \" | Corrected or Error are wrong: \" & to_string(corrected) & to_string(error)); 
    """)




def read_test(test_no):
    random_numbers = [random.randint(0,15) for num in range(4)]
    random_message = "".join([non_noised_messages_strings[num] for num in random_numbers]) 

    stringer = f"""\n
---------------------------------------------------------------------------------------------------
------------------------------ TEST #{test_no} ----------------------------------------------------
---------------------------------------------------------------------------------------------------
wait for 40 ns; -- wait full clock cycle
tb_request <= '1';
tb_write <= '0';
tb_address <= X\"{''.join( [hex(random.randint(0,15))[2:] for i in range(4) ]) }\"; -- random address
wait for 40 ns; -- there is a single clock cycle delay on reading from memory
tb_mem_read_data <= \"{random_message}\";
wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
assert (tb_acknowledge = '1') report \"TEST {test_no} failed, acknowledge was not asserted after one clock cycle.\";
assert (tb_read_data /= X\"{''.join([hex(num)[2:] for num in random_numbers])}\") report \"TEST {test_no} failed, decoded read data wrong\";
wait for 40 ns;
    """
    return stringer



def write_test(test_no):
    random_numbers = [random.randint(0,15) for num in range(4)]
    random_message = "".join([non_noised_messages_strings[num] for num in random_numbers]) 

    stringer = f"""\n
---------------------------------------------------------------------------------------------------
------------------------------ TEST #{test_no} ----------------------------------------------------
---------------------------------------------------------------------------------------------------
wait for 40 ns; -- wait full clock cycle
tb_request <= '1';
tb_write <= '1';
tb_address <= X\"{''.join( [hex(random.randint(0,15))[2:] for i in range(4) ]) }\"; -- random address
tb_write_data <= X\"{''.join([hex(num)[2:] for num in random_numbers])}\";
wait for 40 ns; 
assert (tb_mem_write_data /= \"{random_message}\") report \"TEST {test_no} failed, message encoded wrong\";
wait for 40 ns;
    """
    return stringer


if __name__ == "__main__":
    main()

