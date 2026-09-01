"""
Leet Code Problem Roman to Integer #: 13
Link: https://leetcode.com/problems/roman-to-integer/
"""

class Solution:
    def romanToInt(self, s: str) -> int:
        heap_storage:dict[str,int]={
            "I":1,
            "V":5,
            "X":10,
            "L":50,
            "C":100,
            "D":500,
            "M":1000
        }
        output:int=0
        skip_loop:bool=False
        s_list:list[str]=list(s)
        print(s)
        for index,char in enumerate(s_list):
            if index==len(s_list)-1: 
                if not skip_loop: 
                    output+=heap_storage[char]
                    continue
                else: 
                    break
            if skip_loop: 
                skip_loop=False
                continue
            next_char=s_list[index+1]
            if (next_char=="V" or next_char=="X") and char=="I": 
                output+=heap_storage[next_char]-heap_storage[char]
                skip_loop=True
            elif (next_char=="L" or next_char=="C") and char=="X": 
                output+=heap_storage[next_char]-heap_storage[char]
                skip_loop=True # type: 
            elif (next_char=="D" or next_char=="M") and char=="C": 
                output+=heap_storage[next_char]-heap_storage[char]
                skip_loop=True # type: ignore
            else: 
                output+=heap_storage[char]
        return output

"""
Time complexity is O(N)
Space Complexity is O(N) but can be reduced to O(1) if we don't make convert the str to list
"""