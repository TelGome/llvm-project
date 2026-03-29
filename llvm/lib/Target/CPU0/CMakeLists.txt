add_llvm_component_group(CPU0)

set(LLVM_TARGET_DEFINITIONS CPU0.td)

tablegen(LLVM CPU0GenInstrInfo.inc -gen-instr-info)
tablegen(LLVM CPU0GenRegisterInfo.inc -gen-register-info)
tablegen(LLVM CPU0GenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM CPU0GenMCPseudoLowering.inc -gen-pseudo-lowering)

add_public_tablegen_target(CPU0CommonTableGen)

set(CPU0CodeGen_sources
    CPU0TargetMachine.cpp
  )

add_llvm_target(CPU0CodeGen
  ${CPU0CodeGen_sources}
  LINK_COMPONENTS
  Analysis
  AsmPrinter
  CodeGen
  CodeGenTypes
  Core
  IPO
  MC
  CPU0Desc
  CPU0Info
  Scalar
  SelectionDAG
  Support
  Target
  TargetParser
  TransformUtils
  Vectorize

  ADD_TO_COMPONENT
  CPU0
  )


add_subdirectory(MCTargetDesc)
add_subdirectory(TargetInfo)
