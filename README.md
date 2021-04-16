# MIPS Processor

A five-stage pipelined 32-bit MIPS core written in Verilog

## Overview

![docs](docs/Datapath.pdf)

## Features

- 32-bit MIPS ISA CPU core.
- Branch prediction
- Branches/jumps execute in the ID stage.
- Forwarding to ID/EX from EX/MEM
- Hazard detection

## Execution 

Core designed and synthesized in Vivado. Implemented on the Xilinx Artix-7 FPGA