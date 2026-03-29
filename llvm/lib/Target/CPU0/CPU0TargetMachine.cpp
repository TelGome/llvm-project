//===-- CPU0TargetMachine.cpp - Define TargetMachine for CPU0 -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Top-level implementation for the CPU0 target.
//
//===----------------------------------------------------------------------===//

#include "CPU0TargetMachine.h"
#include "CPU0.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/MC/TargetRegistry.h"

using namespace llvm;

#define DEBUG_TYPE "cpu0"

extern "C" LLVM_ABI LLVM_EXTERNAL_VISIBILITY void LLVMInitializeCPU0Target(){

}


