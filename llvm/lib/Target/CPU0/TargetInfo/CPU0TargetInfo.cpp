//===-- CPU0TargetInfo.cpp - CPU0 Target Implementation -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TargetInfo/CPU0TargetInfo.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/Compiler.h"
using namespace llvm;

Target &llvm::getTheCPU0Target() {
  static Target TheCPU0Target;
  return TheCPU0Target;
}

Target &llvm::getTheCPU0elTarget() {
  static Target TheCPU0elTarget;
  return TheCPU0elTarget;
}

extern "C" LLVM_ABI LLVM_EXTERNAL_VISIBILITY void
LLVMInitializeCPU0TargetInfo() {
  RegisterTarget<Triple::cpu0> X(getTheCPU0Target(), "cpu0",
                                  "CPU0", "CPU0");
  RegisterTarget<Triple::cpu0el> Y(getTheCPU0elTarget(), "cpu0el",
                                    "CPU0el", "CPU0el");
}
