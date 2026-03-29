//===-- CPU0RegisterInfo.td - CPU0 Register defs -----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the CPU0 register file
// https://jonathan2251.github.io/lbd/llvmstructure.html#cpu0-chinese
//===----------------------------------------------------------------------===//
//子寄存器索引 SubRegIndex<size, offset> size：子寄存器大小（bit） offset：起始位置（bit，默认 0）
let Namespace = "CPU0" in {
def sub_32     : SubRegIndex<32>;
def sub_64     : SubRegIndex<64>;
def sub_lo     : SubRegIndex<32>;//低32位
def sub_hi     : SubRegIndex<32, 32>;//高32位
def sub_dsp16_19 : SubRegIndex<4, 16>;
def sub_dsp20    : SubRegIndex<1, 20>;
def sub_dsp21    : SubRegIndex<1, 21>;
def sub_dsp22    : SubRegIndex<1, 22>;
def sub_dsp23    : SubRegIndex<1, 23>;
}

//不可分配寄存器
class Unallocatable {
  bit isAllocatable = 0;
}

// We have banks of 16 registers each. 当前设计的寄存器文件是按“16个为一组”扩展的架构
// bits<16> Enc：硬件编码, string n ：寄存器名字
class CPU0Reg<bits<16> Enc, string n> : Register<n> {
  // For tablegen(... -gen-emitter) in CMakeLists.txt
  let HWEncoding = Enc; //这个寄存器在机器码里的编号
  let Namespace = "CPU0"; //防止不同架构冲突 CPU0::T0
}

// CPU0 CPU Registers.通用寄存器
class CPU0GPRReg<bits<16> Enc, string n> : CPU0Reg<Enc, n>;

// Co-processor 0 Registers 协处理器寄存器
class CPU0C0Reg<bits<16> Enc, string n> : CPU0Reg<Enc, n>;

//===----------------------------------------------------------------------===//
//  Registers
//===----------------------------------------------------------------------===//
// The register string, such as "9" or "gp" will show on "llvm-objdump -d"
//@ All registers definition
let Namespace = "CPU0" in {
  // General Purpose Registers
  def ZERO : CPU0GPRReg< 0, "zero">, DwarfRegNum<[0]>;
  def AT   : CPU0GPRReg< 1, "1">,    DwarfRegNum<[1]>;
  def V0   : CPU0GPRReg< 2, "2">,    DwarfRegNum<[2]>;
  def V1   : CPU0GPRReg< 3, "3">,    DwarfRegNum<[3]>;
  def A0   : CPU0GPRReg< 4, "4">,    DwarfRegNum<[4]>;
  def A1   : CPU0GPRReg< 5, "5">,    DwarfRegNum<[5]>;
  def T9   : CPU0GPRReg< 6, "6">,    DwarfRegNum<[6]>;
  def T0   : CPU0GPRReg< 7, "7">,    DwarfRegNum<[7]>;
  def T1   : CPU0GPRReg< 8, "8">,    DwarfRegNum<[8]>;
  def S0   : CPU0GPRReg< 9, "9">,    DwarfRegNum<[9]>;
  def S1   : CPU0GPRReg< 10, "10">,  DwarfRegNum<[10]>;
  def GP   : CPU0GPRReg< 11, "11">,  DwarfRegNum<[11]>;
  def FP   : CPU0GPRReg< 12, "12">,  DwarfRegNum<[12]>;
  def SP   : CPU0GPRReg< 13, "13">,  DwarfRegNum<[13]>;
  def LR   : CPU0GPRReg< 14, "14">,  DwarfRegNum<[14]>;
  def SW   : CPU0GPRReg< 15, "15">,  DwarfRegNum<[15]>;
  //Cpu0 co-processor 0 registers
  def PC   : CPU0C0Reg<0, "pc">,    DwarfRegNum<[20]>;
  def EPC  : CPU0C0Reg<1, "epc">,   DwarfRegNum<[21]>;
}

//===----------------------------------------------------------------------===//
// Register Classes
//===----------------------------------------------------------------------===//

def CPURegs : RegisterClass<"CPU0", [i32], 32, (add
  // Reserved
  ZERO, AT,
  // Return Values and Arguments
  V0, V1, A0, A1,
  // Not preserved across procedure calls
  T9, T0, T1,
  // Callee save
  S0, S1,
  // Reserved
  GP, FP, SP, LR, SW)>;

// @Status Registers class
def SR : RegisterClass<"CPU0", [i32], 32, (add SW)>;

// @Co-processor 0 Registers class
def C0Regs : RegisterClass<"CPU0", [i32], 32, (add PC, EPC)>;

//用「CPURegs 去掉 SW 之后的寄存器集合」来定义一个新的 RegisterClass，GPROut:这些寄存器可以用来放结果
def GPROut : RegisterClass<"CPU0", [i32], 32, (add (sub CPURegs, SW))>;

