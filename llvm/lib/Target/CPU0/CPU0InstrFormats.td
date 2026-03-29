//===- CPU0InstrFormats.td - CPU0 Instruction Formats-------*- tblgen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Describe CPU0 instructions format
//  http://ccckmit.wikidot.com/ocs:cpu0
// opcode - operation code.
// ra     - dst reg, only used on 3 regs instr.
// rb     - src reg.
// rc     - src reg (on a 3 reg instr).
// cx     - immediate
//===----------------------------------------------------------------------===//

// Format specifies the encoding used by the instruction.  This is part of the
// ad-hoc solution used to emit machine instruction encodings by our machine
// code emitter.
//指令格式数量，4bit可以覆盖16种不同的格式，目前只有5种格式，基础指令集
//5bit包含压缩指令集和自定义指令集
class Format<bits<4> val> {
  bits<4> Value = val;
}
def Pseudo           : Format<0>;
def FrmA             : Format<1>;
def FrmL             : Format<2>;
def FrmJ             : Format<3>;
def FrmOther         : Format<4>; // Instruction w/ a custom format

// Generic CPU0 Format  cpu0基类，继承自 LLVM 内置的 Instruction 类，Instruction 是 TableGen 中所有指令的基类
//输出操作数列表 输入操作数列表 汇编字符串模板 SelectionDAG模式 指令调度信息 指令格式
class CPU0Inst<dag outs, dag ins, string asmstr, list<dag> pattern,
               InstrItinClass itin, Format f>: Instruction
{
  field bits<32> Inst;
  Format Form = f; // 存储指令格式（FrmA/FrmL等）

  let Namespace = "CPU0";

  let Size = 4;

  bits<8> Opcode = 0;

  // Top 8 bits are the 'opcode' field
  let Inst{31-24} = Opcode;

  let OutOperandList = outs;
  let InOperandList  = ins;

  let AsmString   = asmstr;
  let Pattern     = pattern;
  let Itinerary   = itin;

  //
  // Attributes specific to CPU0 instructions...
  //
  bits<4> FormBits     = Form.Value; // 提取格式的数值（0-15）

  let TSFlags{3-0}   = FormBits;  // 存入目标特定标志位

  let DecoderNamespace = "CPU0"; // 反汇编器使用的命名空间

  field bits<32> SoftFail = 0;  // 用于测试的软失败掩码
}

//===----------------------------------------------------------------------===//
// Format A instruction class in CPU0 : <|opcode|ra|rb|rc|cx|> 运算指令，cx表示移位指令的移位量
//===----------------------------------------------------------------------===//

class FA<bits<8> op, dag outs, dag ins, string asmstr,
         list<dag> pattern, InstrItinClass itin>
  : CPU0Inst<outs, ins, asmstr, pattern, itin, FrmA>
{
  bits<4>  ra;
  bits<4>  rb;
  bits<4>  rc;
  bits<12> shamt;

  let Opcode = op;

  let Inst{23-20} = ra;
  let Inst{19-16} = rb;
  let Inst{15-12} = rc;
  let Inst{11-0}  = shamt;
}

//===----------------------------------------------------------------------===//
// Format L instruction class in CPU0 : <|opcode|ra|rb|cx|>  load/store cx表示偏移量
//===----------------------------------------------------------------------===//

class FL<bits<8> op, dag outs, dag ins, string asmstr,
         list<dag> pattern, InstrItinClass itin>
  : CPU0Inst<outs, ins, asmstr, pattern, itin, FrmL>
{
  bits<4>  ra;
  bits<4>  rb;
  bits<16> imm16;

  let Opcode = op;

  let Inst{23-20} = ra;
  let Inst{19-16} = rb;
  let Inst{15-0}  = imm16;
}

//===----------------------------------------------------------------------===//
// Format J instruction class in CPU0 : <|opcode|cx|> jump，cx表示跳转地址
//===----------------------------------------------------------------------===//

class FJ<bits<8> op, dag outs, dag ins, string asmstr,
         list<dag> pattern, InstrItinClass itin>
  : CPU0Inst<outs, ins, asmstr, pattern, itin, FrmJ>
{
  bits<24> addr;

  let Opcode = op;

  let Inst{23-0}  = addr;
}