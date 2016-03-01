This is a simple example for how to use the input file for test pattern generator. 
This can be used for the functional simulation, and not optimized for full compiling. 

test.dat is used as the input for this logic.
It is currently input with (9 characters) x (32 lines). 

1) 9 characters correspond to 8 characters for 32 bits data and 4 bits for extra information.
   In the four extra bits, the LSB is used to tell the termination bit where the read point will be back to the top
2) the number of lines in the files are controlled by "RAM_ADDRESS_WIDTH" of the pattern_generator.
   Currently it is set to 5 and therefore, 32 lines are shown there.
3) As mentioned in 1), in the test.dat, "1e0f00000" will be recognized as the last word in repetition.
   Just to avoid warning message in the simulation, I filled all the 32 lines even though they are not used. 


* How to run.
This is very independent set of test files. So after setting the vivado, you may expand the tar.gz anywhere you want, 
and do the followin:

sh clean.sh
sh functional.sh

we already have a wave configuration (which signals are monitored in simulation_xsim.wcfg) saved and it will be automatically read. 

* files
1) testbench.vhd : testbench description
2) pattern_generator.vhd : pattern generator module, which will give one word per clk when read request is '1'
3) test.dat : which is used as input for the pattern generator
