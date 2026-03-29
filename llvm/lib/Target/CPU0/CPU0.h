//===-- CPU0.h - Top-level interface for CPU0 representation --*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in
// the LLVM CPU0 back-end.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_CPU0_CPU0_H
#define LLVM_LIB_TARGET_CPU0_CPU0_H

#include "MCTargetDesc/CPU0MCTargetDesc.h"
#include "llvm/Target/TargetMachine.h"

namespace llvm {
    class FunctionPass;
    class CPU0TargetMachine;
}

#define ENABLE_GPRESTORE // The $gp register caller saved register enable

#endif