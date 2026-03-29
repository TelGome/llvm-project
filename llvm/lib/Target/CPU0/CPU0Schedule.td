//===-- CPU0Schedule.td - CPU0 Scheduling Definitions ------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Functional units across CPU0 chips sets. Based on GCC/CPU0 backend files.
// FuncUnit：功能单元（硬件资源）
//===----------------------------------------------------------------------===//
def ALU     : FuncUnit; //算术逻辑单元（加减、逻辑运算）
def IMULDIV : FuncUnit; //乘法 / 除法单元

//===----------------------------------------------------------------------===//
// Instruction Itinerary classes used for Cpu0
// InstrItinClass：指令类别
//===----------------------------------------------------------------------===//
def IIAlu              : InstrItinClass;
def IICLO              : InstrItinClass;//count leading ones/zeros
def IICLZ              : InstrItinClass;
def IILoad             : InstrItinClass;
def IIStore            : InstrItinClass;
def IIBranch           : InstrItinClass;
def IIPseudo           : InstrItinClass;

//===----------------------------------------------------------------------===//
// Cpu0 Generic instruction itineraries CPU 的执行模型,每类指令的执行方式
// 每种指令要用什么硬件资源，以及执行多少周期，从而指导指令调度和性能优化
//===----------------------------------------------------------------------===//
def Cpu0GenericItineraries : ProcessorItineraries<[ALU, IMULDIV], [], [
  InstrItinData<IIAlu               ,  [InstrStage<1,   [ALU]>]>,//用alu 一个周期
  InstrItinData<IICLO               ,  [InstrStage<1,   [ALU]>]>,
  InstrItinData<IICLZ               ,  [InstrStage<1,   [ALU]>]>,
  InstrItinData<IILoad              ,  [InstrStage<3,   [ALU]>]>,//3周期，地址计算 + 内存访问 + 返回
  InstrItinData<IIStore             ,  [InstrStage<1,   [ALU]>]>,
  InstrItinData<IIBranch            ,  [InstrStage<1,   [ALU]>]>
]>;