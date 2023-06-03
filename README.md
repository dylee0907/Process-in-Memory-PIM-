# Process-in-Memory-PIM for DFT
PIM architecture for DFT using SRAM

"This is a toy project to verify the activation of Process In Memory".

The designed architecture is based on the operation of mosfet in linear region.
Circuit synthesize possibility is yet to be determined.

We have concluded that after MAC operation ended, the result that goes in to sense amplifier
must come out linearly.

We seperated bitlines and workdlines for positive and negative values which will be summed up after passing through amp.
We used 8-SRAMS per bit cell.

ADC's and DAC's amplifing value has been paramterized and could be changed based on the user since it is to be controled by analog.
The result in testbench shows that increase in value of 2 leads to increase value of 92 in result.

#2023. June. 3

#KHU VLSI Lab

#Dongyoung Lee

#Code available to any users of github

![image](https://github.com/dylee0907/Process-in-Memory-PIM-/assets/79738681/5a37133e-c40b-4996-97cb-a91e6cc5c97a)
![image](https://github.com/dylee0907/Process-in-Memory-PIM-/assets/79738681/f84f7d38-f9a0-4a9e-a017-5ecee59059d3)
