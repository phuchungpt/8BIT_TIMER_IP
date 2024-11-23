Project Overview

This project focuses on verifying the functionality of an 8-bit timer module using SystemVerilog. 
The 8-bit timer is a fundamental component often used in digital systems for generating precise time delays, measuring time intervals, or scheduling events. 
The objective is to create a robust verification environment to ensure the design meets all functional requirements and operates reliably under various conditions.

Project Goals

To develop a verification environment using SystemVerilog.

To ensure the functionality and correctness of the 8-bit timer design.

To achieve 100% functional and code coverage.

Features of the 8-bit Timer:

-  Configure register via APB protocol (IP is APB slave).
-  Only support APB transfer with no wait states and no error handling. 
-  Timer can count up and down.
-  Support polling and interrupt (can be enable or disable).
-  2 clocks domain:
    One for register configuration (pclk): 50 MHz
    Other for clock divisor (ker_clk): 200 MHz

Block diagram 
![image](https://github.com/user-attachments/assets/d554a9e7-1d54-439f-9ca2-cee3060e7c4a)

IO list 
![image](https://github.com/user-attachments/assets/808af0eb-c159-47c6-adb9-a844a7e7a06f)

Register sumary 
![image](https://github.com/user-attachments/assets/f0b32f2b-72b0-491b-aced-51ab038823b4)

COVERAGE
![image](https://github.com/user-attachments/assets/f4987f52-298c-4f2e-91ad-fb463a424a9b)



