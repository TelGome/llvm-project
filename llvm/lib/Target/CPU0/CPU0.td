//===- CPU0.td - Describe the CPU0 Target Machine -----------*- tblgen -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// This is the top level entry point for the CPU0 target.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Target-independent interfaces
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

include "CPU0RegisterInfo.td"
//下面两个文件包含顺序不能改，否则报错？？nt
// 文件从上到下依次处理
// 定义必须在使用之前出现
include "CPU0Schedule.td"
include "CPU0InstrInfo.td"

///Target.td:1424:5: error: missing target override for pseudoinstruction using PointerLikeRegClass
//所有使用 PointerLikeRegClass 的 pseudo 指令 必须通过 RemapAllTargetPseudoPointerOperands 映射到真实寄存器类
//defm : RemapAllTargetPseudoPointerOperands<，mips_ptr_rc>;
//defm : RemapAllTargetPseudoPointerOperands<GPR>;//为什么不使用RISCVReg
defm : RemapAllTargetPseudoPointerOperands<CPURegs>;

def CPU0InstrInfo : InstrInfo {
}

def CPU0 : Target {
  let InstructionSet = CPU0InstrInfo;
}
